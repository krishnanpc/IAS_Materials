#!/usr/bin/env python3
import requests
import subprocess

# This code uses system calls instead of normal requests call
# the first method was implemented using python http requests library
# as a show case of the library. The rest of the methods were implemented
# in system calls to curl for a quicker results. it should be the same
# results but http requests requires more configuration to create headers
# and read data files for upload.


userName = "dr.who"
url = 'http://10.0.0.61:50070/webhdfs/v1/{}?op={}*&user.name={}'


def read_test():
    # reading
    # via url
    r = requests.get(url)
    print(r)
    print(r.text)


# ls, put, get, mkdir, rmdir and rm [-r]
def run_cmd(cmd):
    """Translate command into REST API call and process the response."""
    command = cmd.split(" ")[0]
    if command == "ls":
        r = requests.get(url.format(cmd.split(" ")[1], "OPEN", userName))
        print(r.json())
    elif command == 'put':
        # https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/WebHDFS.html#Append_to_a_File
        # this part usess system call to contact the remote
        # server first creating the file then append toit
        # Sample use
        # >>> PUT <file-name> <file-path>
        fileName = cmd.split(" ")[1]
        system_call = ['curl', '-i', '-X', 'PUT', url.format(
            fileName, 'CREATE', userName)]
        subprocess.call(system_call)
        system_call = ['curl', '-i', '-X', 'POST', url.format(
            fileName, 'APPEND', userName)]
        subprocess.call(system_call)
        system_call = ['curl', '-i', '-X', 'POST', '-T', cmd.slpit(" ")[2],
                       url.format(fileName, 'APPEND', userName)]
        subprocess.call(system_call)

    elif command == 'get':
        # https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/WebHDFS.html#Open_and_Read_a_File
        # this part usess system call to contact the remote
        # to read from file
        # Sample use
        # >>> GET <file-path>
        fileName = cmd.split(" ")[1]
        system_call = ['curl', '-i', '-L', url.format(
            fileName, 'OPEN', userName)]
        subprocess.call(system_call)
    elif command == 'mkdir':
        # https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/WebHDFS.html#Make_a_Directory
        # this part usess system call to contact the remote
        # to read from file
        # Sample use
        # >>> mkdir <folder-Path>
        folderPath = cmd.split(" ")[1]
        system_call = ['curl', '-i', '-X', 'PUT', url.format(
            folderPath, 'MKDIRS', userName)]
        subprocess.call(system_call)
    elif command == 'rmdir':
        # https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/WebHDFS.html#Delete_a_FileDirectory
        # this part usess system call to contact the remote
        # to read from file
        # Sample use
        # >>> rmdir <file-path>
        folderPath = cmd.split(" ")[1]
        system_call = ['curl', '-i', '-X', 'DELETE', url.format(
            folderPath, 'DELETE', userName)]
        subprocess.call(system_call)
    else:
        print 'Command is invalid.'


def repl():
    while True:
        try:
            cmd = input('>>> ')
        except EOFError:
            print('exit')
            break
        if cmd in ['exit', 'bye']:
            break
        elif cmd == '':
            continue
        else:
            run_cmd(cmd)


def login(user):
    userName = user


if __name__ == '__main__':
    # read_test()
    login(input('>>> Enter username: '))
    repl()
