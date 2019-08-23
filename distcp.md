# Tuning options for distcp s3a:

## Disk buffer/fast upload

```
# Use the incremental block upload mechanism with
# the buffering mechanism set in fs.s3a.fast.upload.buffer.
# The number of threads performing uploads in the filesystem is defined
# by fs.s3a.threads.max; the queue of waiting uploads limited by
# fs.s3a.max.total.tasks.
# The size of each buffer is set by fs.s3a.multipart.size. (true)
fs.s3a.fast.upload=true

# Buffer type (disk)
fs.s3a.fast.upload.buffer=disk

# Buffer directory ()
fs.s3a.buffer.dir=${hadoop.tmp.dir}/s3

# Maximum Number of blocks a single output stream can have
# active (uploading, or queued to the central FileSystem
# instance's pool of queued operations. (8)
fs.s3a.fast.upload.active.blocks=2048
```

## Threads

```
# Maximum number of concurrent active (part)uploads, which each use a thread from the threadpool. (10)
fs.s3a.threads.max=2048

# Number of (part)uploads allowed to the queue before blocking additional uploads (5)
fs.s3a.max.total.tasks=2048
```

## Multipart

```
# Multipart size (100M)
fs.s3a.multipart.size=512M
```


## Socket

```
# Socket send buffer hint to amazon connector. Represented in bytes. (8192)
fs.s3a.socket.send.buffer=65536

# Socket receive buffer hint to amazon connector. Represented in bytes. (8192)
fs.s3a.socket.recv.buffer=65536
```

## Connection

```
# Socket connection timeout in milliseconds. (200000)
fs.s3a.connection.timeout=200000

# Controls the maximum number of simultaneous connections to S3. (15)
fs.s3a.connection.maximum=8192

# Socket connection setup timeout in milliseconds (5000)
fs.s3a.connection.establish.timeout=5000

# enable ssl (false)
fs.s3a.connection.ssl.enabled=false
```
