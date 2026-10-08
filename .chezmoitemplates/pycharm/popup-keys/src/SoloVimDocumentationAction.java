package solovim;

import com.intellij.openapi.Disposable;
import com.intellij.openapi.actionSystem.ActionManager;
import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.CommonDataKeys;
import com.intellij.openapi.actionSystem.CustomShortcutSet;
import com.intellij.openapi.actionSystem.KeyboardShortcut;
import com.intellij.openapi.actionSystem.Shortcut;
import com.intellij.openapi.actionSystem.ex.ActionUtil;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.project.DumbAwareAction;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.ui.popup.JBPopup;
import com.intellij.openapi.ui.popup.JBPopupFactory;
import com.intellij.openapi.util.Disposer;
import java.awt.Component;
import java.awt.Container;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.util.Arrays;
import javax.swing.JComponent;
import javax.swing.KeyStroke;
import javax.swing.Timer;

/** Adds a popup-only K shortcut to the IDE's existing documentation action. */
public final class SoloVimDocumentationAction extends DumbAwareAction {
  @Override
  public void actionPerformed(AnActionEvent event) {
    Project project = event.getProject();
    Editor editor = event.getData(CommonDataKeys.EDITOR);
    if (project == null || editor == null) return;

    Disposable lifetime = Disposer.newDisposable("SoloVim documentation popup shortcut");
    Disposer.register(project, lifetime);
    // Documentation loads asynchronously. Poll briefly until its popup has focus.
    Timer retry = new Timer(50, null);
    long deadline = System.nanoTime() + 5_000_000_000L;
    retry.addActionListener(ignored -> {
      if (project.isDisposed() || System.nanoTime() >= deadline) {
        Disposer.dispose(lifetime);
        return;
      }
      JBPopup popup = JBPopupFactory.getInstance().getChildFocusedPopup(editor.getComponent());
      if (popup != null && bindDocumentationAction(popup.getContent())) {
        Disposer.dispose(lifetime);
      }
    });
    Disposer.register(lifetime, () -> retry.stop());
    retry.start();
    AnAction quickDoc = ActionManager.getInstance().getAction("QuickJavaDoc");
    try {
      ActionUtil.performAction(quickDoc, event);
    }
    catch (RuntimeException | Error failure) {
      Disposer.dispose(lifetime);
      throw failure;
    }
  }

  private static boolean bindDocumentationAction(Component component) {
    if (component instanceof JComponent swingComponent) {
      for (AnAction action : ActionUtil.getActions(swingComponent)) {
        // This private popup action is not globally registered with an action ID.
        if (action.getClass().getName().endsWith("DocumentationPopupUI$OpenInToolwindowAction")) {
          Shortcut[] existing = action.getShortcutSet().getShortcuts();
          Shortcut[] shortcuts = Arrays.copyOf(existing, existing.length + 1);
          shortcuts[existing.length] = new KeyboardShortcut(
              KeyStroke.getKeyStroke(KeyEvent.VK_K, InputEvent.SHIFT_DOWN_MASK), null);
          action.registerCustomShortcutSet(new CustomShortcutSet(shortcuts), swingComponent);
          return true;
        }
      }
    }
    if (component instanceof Container container) {
      for (Component child : container.getComponents()) {
        if (bindDocumentationAction(child)) return true;
      }
    }
    return false;
  }
}
