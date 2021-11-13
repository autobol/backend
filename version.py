from sys import argv


def main(commit, version):
    commit = commit.lower()
    change = [bool(commit.find('upgrade') + 1),
              bool(commit.find('update') + 1),
              bool(commit.find('patch') + 1)]
    vers = list(map(int, version.partition('-')[0].split('.')))
    if sum(change) == 1:
        if change.index(1) < 2:
            vers[2] = 0
            if change.index(1) < 1:
                vers[1] = 0
        vers[change.index(1)] += 1
    version = str(vers[0]) + '.' + str(vers[1]) + '.' + str(vers[2])
    return version


if __name__ == '__main__':
    print(main(argv[1], argv[2]))
