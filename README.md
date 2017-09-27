# MOLXPCConnection

A wrapper around NSXPCListener and NSXPCConnection to provide client multiplexing, signature validation of connecting clients and forced connection establishment.

## Installation

Install using CocoaPods.

```
pod 'MOLXPCConnection'
```

## Example

Example server started by `launchd` where the `launchd` job has a `MachServices` key:

```objc
MOLXPCConnection *conn = [[MOLXPCConnection alloc] initServerWithName:@"MyServer"];
conn.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(MyServerProtocol)];
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
Please see the [CONTRIBUTING](https://github.com/google/macops-molxpcconecction/blob/master/CONTRIBUTING.md) file.

