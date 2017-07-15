#!/usr/bin/env python
# pylint: disable=C0103,C0111,C0410

import os, sys, errno
import commands, tempfile, xattr

argv = sys.argv
argc = len(argv)

prog = argv[0]
if argc < 2:
    print 'usage: {} filename...'.format(prog)
    sys.exit(-1)

errcnt = 0
for path in argv[1:]:
    try:
        attr = xattr.getxattr(path, 'com.apple.metadata:kMDItemWhereFroms')
    except IOError as err:
        if err.errno == 93:
            print path
        else:
            print >>sys.stderr, '{}: {}: {}'.format(prog, path, err.strerror)
            errcnt += 1
        continue
    except:
        print >>sys.stderr, '{}: {}: {}'.format(prog, path, sys.exc_info())
        errcnt += 1
        continue

    tmpf = tempfile.mkstemp(suffix='.plist')
    f = os.fdopen(tmpf[0], "w")
    f.write(attr)
    f.close()
    val = commands.getstatusoutput('PlistBuddy -c \'print 0\' ' + tmpf[1])
    os.remove(tmpf[1])
    if val[0] == 0:
        print '{}\t{}'.format(path, val[1])
    else:
        print >>sys.stderr, '{}: {}: {}'.format(prog, val[0], val[1])
        errcnt += 1
        break

sys.exit(errcnt)
