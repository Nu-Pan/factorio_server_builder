load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")

pkg_tar(
    name = "pkg",
    deps = [
        "//server_package:pkg",
        "//runtime_script:pkg",
        "//mods:pkg"
    ],
)

container_image(
    name = "image",
    base = "@server-base//image",
    tars = [":pkg"],
    cmd = ["run_server.sh"],
    ports = ["34197:34197/udp"],    
)

container_push(
    name = "push",
    image = ":image",
    format = "Docker",
    registry = "index.docker.io",
    repository = "nupan/factorio-server",
    tag = "dev",
)

genrule(
    name = "test",
    srcs = [":pkg"],
    outs = ["test.log"],
    cmd = "tar xf $< -C / > $@ 2>&1",
)
