import os 

libPath='/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib/:/lib/x86_64-linux-gnu/:/lib/../lib/:/usr/lib/x86_64-linux-gnu/:/usr/lib/../lib/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../:/lib/:/usr/lib/'

if __name__ == '__main__':
    hasFind = False
    for i in libPath.split(':'):
        p = os.path.abspath(i)
        print('find file in dir:%s ...' % (p)) 
        for _,_,j in os.walk(p):
            for k in j:
                name = os.path.basename(k)
                if name.endswith('l.so'):
                    print('find lib:%s\n' % k)
                if name.lower() == 'l.so':
                    print('already find it:%s\n' % k)
                    hasFind = True
                    break
            if hasFind:
                break
        if hasFind:
            break

    


