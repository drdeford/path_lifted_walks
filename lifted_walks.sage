import matplotlib.pyplot as plt
@interact

def lifted_walk(n=input_box(default=6,label="Path Length (n): "),
numsamples=input_box(default=100,label="Number of Steps (k):"),
pc=selector(["Ordered","Random","Input Your Own"],buttons=True,label="Which Projection?"),
dm=checkbox(default=True, label="Display Matrices?"),
yp=input_box(default=[x+1 for x in range(10)], label="Your Projection: "),
rprob=input_box(default=2/3, label="Probability to step right: "),
auto_update=False):


    if pc == "Random":
        P=Permutations(2*n-2).random_element()

    if pc == "Input Your Own":
    
        P = yp

    if pc == "Ordered":
        P = [x+1 for x in range(2*n-2)]

    pi_inv = {x:[P[2*x-1]-1,P[2*x]-1] for x in range(1,n-1)}
    pi_star = {P[x]-1:floor((x+1)/2) for x in range(2*n-2)}
    pi_inv[0] = [P[0]-1]
    pi_star[P[0]-1] = 0
    pi_inv[n-1] = [P[-1]-1]
    pi_star[P[-1]-1] = n-1


    
    #print(pi_inv)

    path = graphs.PathGraph(n)
    cycle = graphs.CycleGraph(2*n-2)

    clist = rainbow(n)

    pcolors = {clist[x]:[x] for x in range(n)}

    ccolors = {clist[x]:pi_inv[x] for x in range(n)}

    #print(ccolors)

    path.show(vertex_labels=False, vertex_colors=pcolors)

    cycle.show(vertex_labels=False, vertex_colors=ccolors)

    lprob = 1-rprob

    TC = matrix(QQ,2*n-2)

    for i in range(2*n-2):
        TC[i,(i+1)%(2*n-2)]=rprob
        TC[i,(i-1)%(2*n-2)]=lprob
   
    PC = matrix(QQ,n)

    for i in range(n):
        for j in range(n):
            temp=0
            for k in range(len(pi_inv[i])):
                for l in range(len(pi_inv[j])):
                    temp += TC[pi_inv[i][k],pi_inv[j][l]]
               
           
            PC[i,j] = (1/len(pi_inv[i]))*temp


    if dm ==True:
       
        pretty_print("Cycle Transition Matrix: ",TC)
    
        pretty_print("Projected Transition Matrix: ",PC)

        pretty_print("Steady State Vector: ", PC.eigenvectors_left()[0][1]) 


    pvec = [2/(2*n-2) for x in range(1,n-1)]  
    pvec.append(1/(2*n-2))
    pvec.insert(0,1/(2*n-2))


    pstate = 0
    cstate = 0
    pathvec = [0 for x in range(n)]
    cyclevec = [0 for x in range(n)]

    #print(pi_star)

    #print(pi_inv)
    #print(pi_star)

    tvp = []
    tvc = []
    

    for i in range(numsamples):
        pathvec[pstate]+=1
        cyclevec[cstate]+=1

        pstate = choice(path.neighbors(pstate))

        cstate = choice(pi_inv[cstate])

        #print(cstate)
        if random() < rprob:
            cstate = (cstate + 1) % (2*n-2)
        else:
            cstate = (cstate - 1) % (2*n-2)
        #print(cstate)

        cstate = pi_star[cstate]

        tvp.append((1/2)*sum([abs(pathvec[x]/(i+1) - pvec[x]) for x in range(n)]))
        tvc.append((1/2)*sum([abs(cyclevec[x]/(i+1) - pvec[x]) for x in range(n)]))



    plt.figure()
    plt.bar(range(n),pvec)
    plt.title('Path Steady State Distribution')
    ax = plt.gca()
    ax.set_xticks([0,n-1])
    ax.set_xticklabels(['0',str(n-1)])
    plt.xlabel('Node')
    plt.ylabel('Frequency')
    
    plt.show()
    
    plt.figure()
    plt.bar(range(n),[pathvec[x]/numsamples for x in range(n)])
    ax = plt.gca()
    ax.set_xticks([0,n-1])
    ax.set_xticklabels(['0',str(n-1)])
    plt.title('Path Walk Distribution')
    plt.xlabel('Node')
    plt.ylabel('Frequency')
    
    plt.show()

    plt.figure()
    plt.bar(range(n),[cyclevec[x]/numsamples for x in range(n)])
    ax = plt.gca()
    ax.set_xticks([0,n-1])
    ax.set_xticklabels(['0',str(n-1)])
    plt.title('Lifted Walk Distribution')
    plt.xlabel('Node')
    plt.ylabel('Frequency')
    
    plt.show()



    plt.figure()
    
    plt.plot(tvp,'o',markersize=3,color='blue',label='Path')
    plt.plot(tvc,'o',markersize=3,color='green', label="Lifted")
    plt.axhline(y=0,color='r', label="Zero")
    #plt.axhline(y=sum([abs(target_vec[x]-proposal_vec[x]) for x in range(len(alphabet))]),color='y')

    plt.title('Total Variation Distance')
    plt.legend()
    plt.show()

        
        
