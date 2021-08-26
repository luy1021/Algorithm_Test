a1=2.16;a2=2.17;a3=2.16;a4=2.17;
%b1=0.4;b2=0.2;b3=0.4;b4=0.6;
%b1=0.25;b2=0.28;b3=0.36;b4=0.34;600 601 602 603
b1=0.25;b2=0.28;b3=0.36;b4=0.34;
%r1=0.32;r2=0.31;r3=0.29;r4=0.31;
%r1=0.31;r2=0.33;r3=0.30;r4=0.32;
r1=0.31;r2=0.33;r3=0.30;r4=0.32;
C1=9;C2=9;C3=9;C4=9;
D1=2.02;D2=2.02;D3=2.02;D4=2.02;
x1=0;x2=0;x3=0;x4=0;t=1;
while t<=12
syms q1 q2 q3 q4
eq1=a1+r1*log(C1*x1+D1)-log(q1)-1+log(1-q1-q2-q3-q4)-(b1/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
eq2=a2+r2*log(C2*x2+D2)-log(q2)-1+log(1-q1-q2-q3-q4)-(b2/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
eq3=a3+r3*log(C3*x3+D3)-log(q3)-1+log(1-q1-q2-q3-q4)-(b3/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
eq4=a4+r4*log(C4*x4+D4)-log(q4)-1+log(1-q1-q2-q3-q4)-(b4/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
[q1,q2,q3,q4]=solve(eq1,eq2,eq3,eq4,q1,q2,q3,q4)
p1=(1/b1)*(a1+r1*log(C1*x1+D1)-log(q1)+log(1-q1-q2-q3-q4))
p2=(1/b2)*(a2+r2*log(C2*x2+D2)-log(q2)+log(1-q1-q2-q3-q4))
p3=(1/b3)*(a3+r3*log(C3*x3+D3)-log(q3)+log(1-q1-q2-q3-q4))
p4=(1/b4)*(a4+r4*log(C4*x4+D4)-log(q4)+log(1-q1-q2-q3-q4))
pi=(1/b1)*q1*(a1+r1*log(C1*x1+D1)-log(q1)+log(1-q1-q2-q3-q4))+(1/b2)*q2*(a2+r2*log(C2*x2+D2)-log(q2)+log(1-q1-q2-q3-q4))+(1/b3)*q3*(a3+r3*log(C3*x3+D3)-log(q3)+log(1-q1-q2-q3-q4))+(1/b4)*q4*(a4+r4*log(C4*x4+D4)-log(q4)+log(1-q1-q2-q3-q4))
x1=q1;x2=q2;x3=q3;x4=q4;
t=t+1
end
