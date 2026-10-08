package solovim;

import com.intellij.openapi.Disposable;
import com.intellij.openapi.diagnostic.Logger;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.Disposer;
import com.intellij.openapi.wm.ToolWindow;
import com.intellij.openapi.wm.ToolWindowAnchor;
import com.intellij.openapi.wm.ToolWindowManager;
import com.intellij.openapi.wm.ToolWindowType;
import com.intellij.openapi.wm.ex.ToolWindowEx;
import com.intellij.openapi.wm.ex.ToolWindowManagerListener;
import com.intellij.openapi.wm.impl.ToolWindowManagerImpl;
import com.intellij.openapi.wm.impl.WindowInfoImpl;
import com.intellij.toolWindow.ToolWindowPane;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.util.List;
import javax.swing.JRootPane;
import javax.swing.SwingUtilities;
import javax.swing.Timer;

/** Reapplies the saved Project width after Wayland's initial frame configuration. */
public final class SoloVimProjectLayoutListener implements ToolWindowManagerListener {
  private static final Logger LOG = Logger.getInstance(SoloVimProjectLayoutListener.class);
  private boolean started;

  @Override
  public void toolWindowsRegistered(List<String> ids, ToolWindowManager manager) {
    if (ids.contains("Project")) SwingUtilities.invokeLater(() -> restoreAfterStartup(manager));
  }

  private void restoreAfterStartup(ToolWindowManager manager) {
    if (started
        || !Toolkit.getDefaultToolkit().getClass().getName().equals("sun.awt.wl.WLToolkit")
        || !(manager instanceof ToolWindowManagerImpl implementation)) return;
    started = true;
    Project project = implementation.getProject();
    if (project.isDisposed()) return;
    WindowInfoImpl info = implementation.getLayout().getInfo("Project");
    ToolWindow window = manager.getToolWindow("Project");
    if (info == null || info.getType() != ToolWindowType.DOCKED || info.isSplit()
        || info.getAnchor() != ToolWindowAnchor.LEFT || !(window instanceof ToolWindowEx)) return;

    float savedWeight = info.getWeight();
    if (!(savedWeight > 0 && savedWeight < 1)) return;
    ToolWindowPane pane = implementation.getToolWindowPane(window);
    Disposable lifetime = Disposer.newDisposable("SoloVim initial Project width");
    Disposer.register(project, lifetime);
    Timer timer = new Timer(100, null);
    Disposer.register(lifetime, () -> timer.stop());
    long startedAt = System.nanoTime();
    int initialWidth = pane.getRootPane() == null ? 0 : pane.getRootPane().getWidth();
    int[] lastWidth = {-1, -1};
    long[] stableSince = {startedAt};
    LOG.info("SoloVim Project layout: saved weight=" + savedWeight
        + ", initial root width=" + initialWidth);
    timer.addActionListener(ignored -> {
      long now = System.nanoTime();
      if (project.isDisposed() || now - startedAt >= 30_000_000_000L) {
        Disposer.dispose(lifetime);
        return;
      }
      JRootPane root = pane.getRootPane();
      if (root == null || !root.isShowing() || root.getWidth() <= 0 || !window.isVisible()) return;
      int width = root.getWidth();
      if (width != lastWidth[0]) {
        lastWidth[0] = width;
        stableSince[0] = now;
      }
      // Check the initial frame too: it may have resized before registration.
      // Continue watching startup, but apply only once per root width. Panel
      // drags leave the root width unchanged and therefore remain untouched.
      if (width == lastWidth[1] || now - stableSince[0] < 500_000_000L) return;
      if (window.getType() == ToolWindowType.DOCKED && window.getAnchor() == ToolWindowAnchor.LEFT) {
        Dimension panelSize = pane.getComponentSize(window);
        if (panelSize == null) {
          Disposer.dispose(lifetime);
          return;
        }
        int before = panelSize.width;
        int desired = (int) (width * savedWeight);
        if (Math.abs(before - desired) > 2) {
          ((ToolWindowEx) window).stretchWidth(desired - before);
          root.validate();
        }
        LOG.info("SoloVim Project layout: root width=" + width + ", panel before=" + before
            + ", requested=" + desired + ", panel after=" + pane.getComponentSize(window));
        lastWidth[1] = width;
      }
    });
    timer.start();
  }
}
