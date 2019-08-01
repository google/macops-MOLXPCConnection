load("@build_bazel_rules_apple//apple:macos.bzl", "macos_unit_test")

objc_library(
    name = "MOLXPCConnection",
    srcs = ["Source/MOLXPCConnection/MOLXPCConnection.m"],
    hdrs = ["Source/MOLXPCConnection/MOLXPCConnection.h"],
    copts = ["-Wunguarded-availability"],
    includes = ["Source"],
    sdk_frameworks = ["Security"],
    visibility = ["//visibility:public"],
    deps = ["@MOLCodesignChecker"],
)

objc_library(
    name = "MOLXPCConnectionTestsLib",
    testonly = 1,
    srcs = ["Tests/MOLXPCConnectionTests.m"],
    copts = ["-Wunguarded-availability"],
    deps = [
        ":MOLXPCConnection",
        "@OCMock",
    ],
)

macos_unit_test(
    name = "MOLXPCConnectionTests",
    minimum_os_version = "10.11",
    deps = [":MOLXPCConnectionTestsLib"],
)
