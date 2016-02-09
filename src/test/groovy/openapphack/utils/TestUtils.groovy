package openapphack.utils


class TestUtils {

    static final DEFAULT_BASE_DIR = "/tmp/app-test"

    static File prepareBaseDir() {
        def counter = "${(Math.random() * 10000).toInteger()}".padLeft(4, "0")
        def baseDir = "$DEFAULT_BASE_DIR/app-$counter" as File
        baseDir.mkdirs()
        baseDir
    }
}
