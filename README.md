Containers in Go
================

After watching a really interesting talk
[What is a container, really? Let's write one in Go from scratch](https://www.youtube.com/watch?v=HPuvDm8IC-4)
by Liz Rice at Golang UK Conference 2016, and
[Golang, Threads, and You](https://docs.google.com/presentation/d/1yY0fkuvcUoEa1jGNMQnBsUWrVqXOqTfbnPX6qu-UDk8/edit#slide=id.p)
by Casey Callendrello at a Golang meetup in Berlin, I decided to experiment with this idea of
"building a container system" and testing the limits of making syscalls inside a Go program
to see the limits and the dangers (a.k.a. the fun part) of playing with some really low level
syscalls.

This is a working in progress.

Setup
-----
Vagrant is used to manage a virtual machine, this provides a safer environment to play with.

To start the VM run ``vagrant up`` then ``vagrant ssh`` to login into the VM

To copy the whole filesystem of the host machine to a different directory and use it as
a guest (container) filesystem, run:

```
# rsync -axHWAX --numeric-ids --info=progress2 / /mnt/containerfs/fs
```

Running
-------
The program needs to run as root:

 ```
 # go run main.go run <command> <args>
 ```
