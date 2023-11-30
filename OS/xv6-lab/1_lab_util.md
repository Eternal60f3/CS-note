sleep

```c
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]) {
  if (argc == 1) {
    printf("lose argument\n");
    exit(0);
  }

  int cnt = atoi(argv[1]);
  sleep(cnt);

  exit(0);
}
```



pingpong

```c
#include "kernel/types.h"
#include "user/user.h"


int main(int argc, char* argv[]) {
  int parent_fd[2], child_fd[2];
  pipe(parent_fd);
  pipe(child_fd);
  char buf[64];

  if (fork()) {
    // Parent
    write(parent_fd[1], "ping", strlen("ping"));
    read(child_fd[0], buf, 4);
    printf("%d: received %s\n", getpid(), buf);
  }
  else {
    // Child
    read(parent_fd[0], buf, 4);
    printf("%d: received %s\n", getpid(), buf);
    write(child_fd[1], "pong", strlen("pong"));
  }

  exit(0);
}
```



primes

```c
#include "kernel/types.h"
#include "user/user.h"

void redirect(int k, int pd[]) {
    close(k);
    dup(pd[k]);
    close(pd[0]), close(pd[1]);
}

void cull(int base) {
    int num;
    while (read(0, &num, sizeof(num)) == sizeof(num))
        if (num % base != 0)
            write(1, &num, sizeof(num));
}

void sink() {
    int base;
    if (read(0, &base, sizeof(base)) != sizeof(base))
        return;
    printf("prime %d\n", base);

    int pd[2];
    pipe(pd);

    if (fork() == 0) {
        redirect(1, pd);
        cull(base);
        exit(0);
    }
    redirect(0, pd);
    sink();
}

void source() {
    for (int i = 2; i <= 35; ++i)
        write(1, &i, sizeof(i));
}

int main() {
    int pd[2];
    pipe(pd);

    if (fork() == 0) {
        redirect(1, pd);
        source();
        exit(0);
    }
    redirect(0, pd);
    sink();

    wait(0);
    exit(0);
}
```



find

> remain the **hard version** to finish

```c
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

// use KMP algorithm
int in_str(char* mb, char* spec) {
    int nxt[DIRSIZ] = { 0 };
	
    nxt[0] = 0;
    for (int i = 1, j = 0; i < strlen(spec); ++i) {
        while (j > 0 && spec[i] != spec[j])
            j = nxt[j - 1];
        j += (spec[i] == spec[j]);
        nxt[i] = j;
    }

    for (int i = 0, j = 0; i < strlen(mb); ++i) {
        while (j > 0 && mb[i] != spec[j])
            j = nxt[j - 1];
        j += (mb[i] == spec[j]);

        if (j == strlen(spec))
            return 1;
    }
    return 0;
}

void find(int dir_file, char path[512], char* find_name) {
    struct dirent de;
    struct stat st;

    char* p = path + strlen(path);
    *p++ = '/'; // 记得把path末尾置零

    while (read(dir_file, &de, sizeof(de)) == sizeof(de)) {
        if (strlen(path) + 1 + DIRSIZ + 1 > 512) {
            printf("ls: path too long\n");
            break;
        }

        if (de.inum == 0)
            continue;

        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;

        if (stat(path, &st) < 0) {
            printf("ls: canot stat %s\n", path);
            continue;
        }

        if (st.type == T_DIR && strcmp(de.name, ".") != 0 && strcmp(de.name, "..") != 0) {
            int fd;
            if ((fd = open(path, 0)) < 0) {
                fprintf(2, "ls: cannot open %s\n", path);
                return;
            }

            find(fd, path, find_name);
        }
        else if (st.type == T_FILE) {
            if (strcmp(de.name, find_name) == 0)
                printf("%s\n", path);
        }
    }

    close(dir_file);
    return;
}

int main(int argc, char* argv[]) {
    char* dir_path, * find_name;

    if (argc == 2) {
        dir_path = ".";
        find_name = argv[1];
    }
    else if (argc == 3) {
        dir_path = argv[1];
        find_name = argv[2];
    }
    else {
        printf("lose argument\n");
        exit(0);
    }


    int fd;
    struct stat st;


    if ((fd = open(dir_path, 0)) < 0) {
        fprintf(2, "ls: cannot open %s\n", dir_path);
        exit(0);
    }

    if (fstat(fd, &st) < 0) {
        fprintf(2, "ls: cannot stat %s\n", dir_path);
        close(fd);
        exit(0);
    }

    if (st.type != T_DIR) {
        fprintf(2, "dir_path isn't dir\n");
        close(fd);
        exit(0);
    }

    char buf[512];
    buf[0] = '.';
    buf[1] = '\0';
    find(fd, buf, find_name);

    exit(0);
}
```



xargs

```c
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"

#define MAX_PARAM_LEN 512


int main(int argc, char* argv[]) {
    char* cmd = argv[1];
    char* args[MAXARG];
    int args_i = 0;
    args[args_i++] = cmd;
    args[args_i++] = argv[2];


    char param[512];
    int param_i = 0;
    char ch;
    int ignore = 0;
    while ((read(0, &ch, 1)) > 0) {
        // printf("%c\n", ch);
        if (ch != '\n') {
            if (param_i > MAX_PARAM_LEN) {
                fprintf(2, "param too long\n");
                ignore = 1;
                continue;
            }
            // printf("in read param_i: %d\n", param_i);
            param[param_i++] = ch;
        }
        else {
            if (ignore) {
                ignore = 0;
                continue;
            }
            param[param_i++] = '\0';

            args[args_i] = malloc(strlen(param) + 1);
            memcpy(args[args_i], param, strlen(param) + 1);
            // printf("cmd: %s, param1: %s, param2: %s\n", cmd, args[1], args[args_i]);
            if (fork() == 0) {
                exec(cmd, args);
                fprintf(2, "exec error, end_arg: %s\n", args[args_i]);
            }
            param_i = 0;
        }
    }

    // printf("param_i: %d\n", param_i);
    if (param_i != 0 && !ignore) {
        param[param_i++] = '\0';
        memcpy(args[args_i], param, strlen(param) + 1);
        if (fork() == 0) {
            exec(cmd, args);
            fprintf(2, "exec error, end_arg: %s\n", args[args_i]);
        }
        param_i = 0;
    }

    while (wait(0) > 0);
    exit(0);
}
```

