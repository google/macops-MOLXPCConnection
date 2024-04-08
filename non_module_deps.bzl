load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def _non_module_deps_impl(ctx):
  # OCMock is used in several tests.
  git_repository(
    name = "OCMock",
    build_file_content = """
objc_library(
    name = "OCMock",
    testonly = 1,
    hdrs = glob(["Source/OCMock/*.h"]),
    copts = [
        "-Wno-vla",
    ],
    includes = [
        "Source",
        "Source/OCMock",
    ],
    non_arc_srcs = glob(["Source/OCMock/*.m"]),
    pch = "Source/OCMock/OCMock-Prefix.pch",
    visibility = ["//visibility:public"],
)
""",
    commit = "afd2c6924e8a36cb872bc475248b978f743c6050",  # tag = v3.9.1
    remote = "https://github.com/erikdoe/ocmock",
    shallow_since = "1635703064 +0100",
)

non_module_deps = module_extension(implementation = _non_module_deps_impl)
