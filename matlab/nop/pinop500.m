a1=3.14;a2=3.16;a3=3.16;a4=3.11;b1=0.47;b2=0.36;b3=0.39;b4=0.9;
x1=0;x2=0;x3=0;x4=0;t=1;
while t<=1
syms q1 q2 q3 q4
eq1=a1-log(q1)-1+log(1-q1-q2-q3-q4)-(b1/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
eq2=a2-log(q2)-1+log(1-q1-q2-q3-q4)-(b2/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
eq3=a3-log(q3)-1+log(1-q1-q2-q3-q4)-(b3/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
eq4=a4-log(q4)-1+log(1-q1-q2-q3-q4)-(b4/(1-q1-q2-q3-q4))*(q1/b1+q2/b2+q3/b3+q4/b4);
[q1,q2,q3,q4]=solve(eq1,eq2,eq3,eq4,q1,q2,q3,q4)
p1=(1/b1)*(a1-log(q1)+log(1-q1-q2-q3-q4))
p2=(1/b2)*(a2-log(q2)+log(1-q1-q2-q3-q4))
p3=(1/b3)*(a3-log(q3)+log(1-q1-q2-q3-q4))
p4=(1/b4)*(a4-log(q4)+log(1-q1-q2-q3-q4))
pi=(1/b1)*q1*(a1-log(q1)+log(1-q1-q2-q3-q4))+(1/b2)*q2*(a2-log(q2)+log(1-q1-q2-q3-q4))+(1/b3)*q3*(a3-log(q3)+log(1-q1-q2-q3-q4))+(1/b4)*q4*(a4-log(q4)+log(1-q1-q2-q3-q4))
x1=q1;x2=q2;x3=q3;x4=q4;
t=t+1
end
