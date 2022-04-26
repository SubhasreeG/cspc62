with open('icg_opt.txt', 'r') as f:
    f1 = open('sc.txt', 'w')
    data = f.read().splitlines()
    for line in data:
        a,b = line.split('=')
        x, y = None, None
        arr = ['+', '-', '*', '/', '&', '|', '^']
        ma = {'+':'ADD', '-':'SUB', '*':'MUL', '&':'AND', '|':'OR', '^':'XOR'}
        if '+' in b or '-' in b or '*' in b or '/' in b or '&' in b or '|' in b or '^' in b:
            for cc in arr:
                if cc in b:
                    x, y = b.split(cc)
                    if x[0] == 't' and y[0] == 't':
                        if len(x) >= 2 and x[1] in '1234567890' and len(y) >= 2 and y[1] in '1234567890':
                            f1.write(ma[cc] + ' r' + x[1:] + ' r' + y[1:] + ' ' + a + '\n')
                            break
                    if x[0] == 't':
                        if len(x) >= 2 and x[1] in '1234567890':
                            f1.write(ma[cc] + ' r' + x[1:] + ' ' + y + ' ' + a + '\n')
                            break
                    if y[0] == 't':
                        if len(y) >= 2 and y[1] in '1234567890':
                            f1.write(ma[cc] + ' r' + y[1:] + ' ' + x + ' ' + a + '\n')
                            break
                    # f1.write('')
                    f1.write('MOV ' + x + ' r12\n')
                    f1.write(ma[cc] + ' r12 ' + y + ' ' + a + '\n')
        else:
            if a[0] == 't' and b[0] == 't':
                if len(a) >= 2 and a[1] in '1234567890' and len(b) >= 2 and b[1] in '1234567890':
                    f1.write('MOV' + ' r' + b[1:] + ' r' + a[1:] + '\n')
                    continue
            if a[0] == 't':
                if len(a) >= 2 and a[1] in '1234567890':
                    f1.write('MOV ' + b + ' r' + a[1:] + '\n')
                    continue
            if b[0] == 't':
                if len(b) >= 2 and b[1] in '1234567890':
                    f1.write('MOV' + ' r' + b[1:] + ' ' + a + '\n')
                    continue
            # f1.write('')
            f1.write('MOV ' + b + ' r12\n')
            f1.write('MOV' + ' r12 ' + a  + '\n')
        # f1.close()
