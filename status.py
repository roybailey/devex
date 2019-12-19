#!/usr/bin/python3

import os
import sys
import subprocess
import logging

logging.basicConfig(level=logging.INFO)


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


# capture the filenames from a folder
def ls(folder):
    cmd = ["ls", "-l", folder]
    logging.debug("Running {}".format("".join([n + " " for n in cmd])))
    lsoutput = subprocess.check_output(cmd).decode('utf-8').split('\n')
    names = [x.split()[8] for x in lsoutput if len(x.split()) == 9]
    names = [x for x in names if os.path.isdir(x)]
    return names;


# class for git status result
class GitStatus:
    def __init__(self, folder):
        self.folder = folder
        self.branch = ""
        self.message = ""
        self.color = None

    def toInfo(self, a, b):
        result = self.folder.ljust(a) + '[' + self.branch.center(b) + '] > ' + self.message
        if self.color != None:
            result = self.color + result + bcolors.ENDC
        return result

    def __str__(self):
        result = self.toInfo(len(self.folder) + 2, len(self.branch) + 2)
        return result

    def process(self, output):
        msgFilter = [
            "nothing to commit, working tree clean",
            "Changes to be committed:",
            "Untracked files:",
            "Changes not staged for commit:"]
        self.message = "".join([msg.replace(':', '') + ", " for msg in output if msg in msgFilter])
        self.color = bcolors.OKGREEN if self.message == msgFilter[0] + ", " else bcolors.FAIL


# capture the filenames from a folder
def gs(folder):
    result = GitStatus(folder)
    cmd = ["git", "status"]
    cmdecho = "".join([n + " " for n in cmd])
    cwd = os.getcwd()
    logging.debug("Running {} in {}/{}".format(cmdecho, os.getcwd(), folder))
    os.chdir(folder)
    try:
        output = subprocess.check_output(cmd, stderr=subprocess.STDOUT).decode('utf-8').split('\n')
        logging.debug(output)
        result.branch = output[0].split()[2]
        result.process(output)
    except subprocess.CalledProcessError as err:
        logging.debug(err.output.decode('utf-8'))
        result.message = err.output.decode('utf-8').split('\n')[0]
    logging.debug("Results from {}\n{}".format(cmdecho, str(result)))
    os.chdir(cwd)
    return result;


#
# Main program 
#

dir_path = os.path.dirname(os.path.realpath(__file__))
logging.debug("Running script from {}".format(dir_path))

if (len(sys.argv) > 1):
    folder = sys.argv[1]
else:
    folder = "."

folders = ls(folder)

results = []
for line in folders:
    logging.debug("Processing...{}".format(line))
    r = gs(folder + "/" + line)
    print(r.toInfo(40, 16))
    results.append(r)

if (logging.getLogger().getEffectiveLevel() == logging.DEBUG):
    print("##### RESULTS #####")
    for r in results:
        print(r.toInfo(40, 16))
