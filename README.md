# MOLXPCConnection

A wrapper around NSXPCListener and NSXPCConnection to provide client multiplexing,
signature validation of connecting clients, forced connection establishment and
different exported interfaces for privileged/unprivileged clients.

## Installation

#### Using [Bazel](http://bazel.build) Modules

Add the following to your MODULE.bazel:

```bazel
bazel_dep("molxpcconnection", version = "2.1", repo_name = "MOLXPCConnection")
git_override(
    module_name = "molxpcconnection",
    remote = "https://github.com/google/macops-molxpcconnection.git",
    tag = "v2.1",
)
```

#### Using [Bazel](http://bazel.build) WORKSPACE

Add the following to your WORKSPACE:

```
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Needed for MOLXPConnection
git_repository(
    name = "MOLCertificate",
    remote = "https://github.com/google/macops-molcertificate.git",
    tag = "v2.0",
)

# Needed for MOLXPCConnection
git_repository(
    name = "MOLCodesignChecker",
    remote = "https://github.com/google/macops-molcodesignchecker.git",
    tag = "v2.0",
)

git_repository(
    name = "MOLXPCConnection",
    remote = "https://github.com/google/macops-molxpcconnection.git",
    tag = "v2.1",
)
```

### Adding dependency in BUILD

In your BUILD file, add MOLXPCConnection as a dependency:

<pre>
objc_library(
    name = "MyAwesomeApp_lib",
    srcs = ["src/MyAwesomeApp.m", "src/MyAwesomeApp.h"],
    <strong>deps = ["@MOLXPCConnection//:MOLXPCConnection"],</strong>
)
</pre>


## Example

Example server started by `launchd` where the `launchd` job has a `MachServices` key:

```objc
MOLXPCConnection *conn = [[MOLXPCConnection alloc] initServerWithName:@"MyServer"];
conn.privilegedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(MyServerProtocol)];
conn.exportedObject = myObject;
[conn resume];
```

Example client, connecting to above server:

```objc
MOLXPCConnection *conn = [[MOLXPCConnection alloc] initClientWithName:"MyServer" withOptions:0];
conn.remoteInterface = [NSXPCInterface interfaceWithProtocol:@protocol(MyServerProtocol)];
conn.invalidationHandler = ^{ NSLog(@"Connection invalidated") };
[conn resume];
```

The client can send a message to the server with:

```objc
[conn.remoteObjectProxy selectorInRemoteInterface];
```

One advantage of the way that MOLXPCConnection works over using NSXPCConnection directly is that from the client-side once the resume method has finished, the connection is either valid or the invalidation handler will be called. Ordinarily, the connection doesn't actually get made until the first message is sent across it.

`messages are always delivered on a background thread!`

## Documentation

Reference documentation is at CocoaDocs.org:

http://cocoadocs.org/docsets/MOLXPCConnection

## Contributing

Patches to this library are very much welcome.
Please see the [CONTRIBUTING](https://github.com/google/macops-molxpcconnection/blob/master/CONTRIBUTING.md) file.

