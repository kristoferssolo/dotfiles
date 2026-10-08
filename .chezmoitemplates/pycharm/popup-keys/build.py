"""Build against an installed PyCharm 2026.2, without downloading dependencies."""

import argparse
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
from zipfile import ZIP_DEFLATED, ZipFile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("ide_home", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--install-dir", type=Path)
    args = parser.parse_args()
    source = Path(__file__).resolve().parent
    java = next((candidate for candidate in (
        args.ide_home / "jbr/bin/java",
        args.ide_home / "jbr/Contents/Home/bin/java",
    ) if candidate.is_file()), None)
    if java is None:
        parser.error("No bundled Java runtime found in the IDE installation")
    # IntelliJ's Java APIs and their Kotlin dependencies are all shipped in lib.
    classpath = os.pathsep.join(str(p) for p in (args.ide_home / "lib").rglob("*.jar"))
    with tempfile.TemporaryDirectory(prefix="solovim-popup-keys-") as directory:
        temporary = Path(directory)
        classes = temporary / "classes"
        classes.mkdir()
        subprocess.run([
            str(java), "-m", "jdk.compiler/com.sun.tools.javac.Main", "-proc:none",
            "--release", "21", "-classpath", classpath, "-d", str(classes),
            *(str(path) for path in sorted((source / "src").glob("*.java"))),
        ], check=True)
        jar = temporary / "solovim-popup-keys.jar"
        with ZipFile(jar, "w", ZIP_DEFLATED) as archive:
            archive.write(source / "plugin.xml", "META-INF/plugin.xml")
            for compiled in classes.rglob("*.class"):
                archive.write(compiled, compiled.relative_to(classes).as_posix())
        args.output.parent.mkdir(parents=True, exist_ok=True)
        with ZipFile(args.output, "w", ZIP_DEFLATED) as archive:
            archive.write(jar, "SoloVimPopupKeys/lib/solovim-popup-keys.jar")
        if args.install_dir is not None:
            # Quit PyCharm before using this option so plugin files are not in use.
            destination = args.install_dir / "SoloVimPopupKeys/lib"
            destination.mkdir(parents=True, exist_ok=True)
            shutil.copy2(jar, destination / jar.name)
        print(args.output.resolve())


if __name__ == "__main__":
    main()
