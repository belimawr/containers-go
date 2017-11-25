package main

import (
	"fmt"
	"os"
	"os/exec"
	"path"
	"syscall"
)

const (
	cmdPos  = 1
	imgPos  = 2
	execPos = 3
	argsPos = 4
)

// go run main.go image run command args

func main() {
	if len(os.Args) < 4 {
		fmt.Println("usage: go run main.go run <image> <command> <args>")
	}

	switch os.Args[cmdPos] {
	case "run":
		run()
	case "child":
		child()
	default:
		panic("what?")
	}
}

func run() {
	cmd := exec.Command("/proc/self/exe", append([]string{"child"}, os.Args[imgPos:]...)...)
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
	cmd.Stdout = os.Stdout

	cmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags: syscall.CLONE_NEWUTS | syscall.CLONE_NEWPID | syscall.CLONE_NEWNS,
	}

	must(cmd.Run())
}

func child() {
	image := os.Args[imgPos]
	fmt.Printf("Image: %q\n", image)
	fmt.Printf("running %v as pid: %d\n", os.Args[execPos:], os.Getpid())

	must(syscall.Chroot(path.Join("images", os.Args[imgPos])))
	must(os.Chdir("/"))
	must(syscall.Mount("proc", "proc", "proc", 0, ""))

	cmd := exec.Command(os.Args[execPos], os.Args[argsPos:]...)
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
	cmd.Stdout = os.Stdout

	must(cmd.Run())
}

func must(err error) {
	if err != nil {
		panic(err)
	}
}
