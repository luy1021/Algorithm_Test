a1=3.17;a2=3.18;a3=3.22;b1=0.15;b2=0.17;b3=0.13;D1=1.05;D2=1.05;D3=1.06;r1=0.28;r2=0.31;r3=0.33;C1=7.99;C2=8.00;C3=8.00;
x1=0;x2=0;x3=0;t=1;
while t<=12
syms q1 q2 q3
eq1=a1+r1*log(C1*x1+D1)-log(q1)-1+log(1-q1-q2-q3)-(b1/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
eq2=a2+r2*log(C2*x2+D2)-log(q2)-1+log(1-q1-q2-q3)-(b2/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
eq3=a3+r3*log(C3*x3+D3)-log(q3)-1+log(1-q1-q2-q3)-(b3/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
[q1,q2,q3]=solve(eq1,eq2,eq3,q1,q2,q3)
p1=(1/b1)*(a1+r1*log(C1*x1+D1)-log(q1)+log(1-q1-q2-q3))
p2=(1/b2)*(a2+r2*log(C2*x2+D2)-log(q2)+log(1-q1-q2-q3))
p3=(1/b3)*(a3+r3*log(C3*x3+D3)-log(q3)+log(1-q1-q2-q3))
pi=(1/b1)*q1*(a1+r1*log(C1*x1+D1)-log(q1)+log(1-q1-q2-q3))+(1/b2)*q2*(a2+r2*log(C2*x2+D2)-log(q2)+log(1-q1-q2-q3))+(1/b3)*q3*(a3+r3*log(C3*x3+D3)-log(q3)+log(1-q1-q2-q3))
x1=q1;x2=q2;x3=q3;
t=t+1
end
