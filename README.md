<h1 align="center">Myopic Policy</h1>
<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#background">Background</a>
    </li>
    <li>
      <a href="#tools">Tools</a>
      <ul>
        <li><a href="#sas">SAS</a></li>
        <li><a href="#matlab">MATLAB</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <ul>
        <li><a href="#sas files">SAS Files</a></li>
        <li><a href="#matlab files">MATLAB Files</a></li>
      <ul>
        <li><a href="#optimal file">Optimal File</a></li>
        <li><a href="#myopic file">Myopic File</a></li>
        <li><a href="#onestep file">Onestep File</a></li>
        <li><a href="#nop file">Nop File</a></li>
      </ul>
    </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- Background -->
## Background
There are two purposes of this project, the first is to test consumer utility in addition to the affected by the product price, whether also will be affected by the network effect, the second is to determine the consumer utility under the influence of network effects and price, according to the sensitive coefficient of impact factors, determine the optimal pricing under the different policy of product and the corresponding profits.

<!-- Tools -->
## Tools
The application of this project requires two tools, SAS software and MATLAB software.
### SAS
First, we use SAS software to compare the model expressiveness and prediction accuracy of the two models without network effect and with network effect, and test whether the consumer utility is affected by network effect. Moreover, by comparing the utility models of network effects in different functional forms, the influence forms of network effects can be judged. Specifically, it can be divided into linear form and logarithmic form.
### MATLAB
Then, the sensitivity coefficients of different impact factors are estimated by using the above analysis conclusions, and the optimal pricing and corresponding profits under different pricing policy are calculated by MATLAB software. Specifically, it includes optimal pricing policy, myopic pricing policy, one-step pricing policy, and standard MNL model pricing policy without considering network effects.

<!-- USAGE EXAMPLES -->
## Usage
<!-- SAS Files -->
### SAS Files
There are three folders in the SAS folder, which correspond to SAS codes of different kinds of products. The following takes 110g menlon seeds as an example to explain the use of relevant codes.<br>

In the 110g folder, there are three SAS code files, among which "try110nop.sas" means that in the consumer utility function, only the influence of product price is considered to establish the model; "try110xx.sas" means that in the consumer utility function, the influence of linear form of network effect is considered to establish the model. "try110.sas" means that the network effect in logarithmic form is considered in the consumer utility function to build a model. Take the try110.sas code file as an example.<br>

First, we import the "TRY110" data file and explain the contents of the data file. In this case, the data file is an Excel file, and the fields include: classification variable melon_seeds, where "1" represents caramal seeds, "2" represents red date seeds, "3" represents original taste seeds, and "4" means nonpurchase people. "price" is the price of the product, "x" is the sales volume in the last month of each product, "xx" is the market share in the last month, and "zong" is the whole sales volume in the last month. "ln" is the network effect, where ln=log (C*xx+D), the values of C and D are related to the product.<br>
```
proc contents data = WORK.TRY110;
	run;
  
proc format;
value melon_seeds_l 
  1="caramel"
  2="red date" 
  3="origin"
  4="nonpurchase";
run;
```
After that, we make descriptive statistics for the relevant data in the data file, and the code is as follows???<br>
```
proc freq data = WORK.TRY110;
	format melon_seeds melon_seeds_l.;
	table melon_seeds;
run;

proc means data = WORK.TRY110;
	format melon_seeds melon_seedsl.;
	var price ln= WORK.TRY110;
	run;
```
Finally, logistic regression in SAS is used to test the explanatory power and prediction accuracy of the model. In this example, we get the results of the model under the dual influence of price and logarithmic network effect. The following is a code example:<br>
```
proc logistic data = WORK.TRY110;
	model melon_seeds = price ln/ link = glogit;
run;
```
<!-- MATLAB Files -->
### MATLAB Files
Under the MATLAB folder we created four folders based on different pricing policy, The "optimal" file, "myopic" file, "onestep" file, and "nop" file represent the optimal pricing policy, the myopic pricing policy, the onestep-ahead pricing policy, and the standard MNL model pricing strategy without network effects, respectively. We will explain how to use the code one by one.
<!-- Optimal File -->
#### Optimal File
In the optimal file, we divide it by product category. Taking the "optimal110.m" code file as an example, we first input the correlation coefficient required by the model.
```
a1=1.15;a2=1.16;a3=1.12;b1=0.16;b2=0.25;b3=0.29;D1=2.06;D2=2.03;D3=2.03;r1=0.67;r2=0.78;r3=0.69;C1=9.99;C2=10.01;C3=10.00;
x1=0;x2=0;x3=0;theta=0.99;
t=1;
```
After that, the profit function is established with the goal of maximizing the total revenue, and the upper and lower bounds of the cycles and decision variables are set up, and the solution is carried out. The code is as follows:

```
while t<=1
f=@(x)(-((1/b1)*x(1)*(a1+r1*log(C1*x(4)+D1)-log(x(1))+log(1-x(1)-x(2)-x(3)))+...
    (1/b2)*x(2)*(a2+r2*log(C2*x(5)+D2)-log(x(2))+log(1-x(1)-x(2)-x(3)))+...
    (1/b3)*x(3)*(a3+r3*log(C3*x(6)+D3)-log(x(3))+log(1-x(1)-x(2)-x(3)))+...
    theta*((1/b1)*x(4)*(a1+r1*log(C1*x(7)+D1)-log(x(4))+log(1-x(4)-x(5)-x(6)))+...
    (1/b2)*x(5)*(a2+r2*log(C2*x(8)+D2)-log(x(5))+log(1-x(4)-x(5)-x(6)))+...
    (1/b3)*x(6)*(a3+r3*log(C3*x(9)+D3)-log(x(6))+log(1-x(4)-x(5)-x(6))))+...
    theta^2*((1/b1)*x(7)*(a1+r1*log(C1*x(10)+D1)-log(x(7))+log(1-x(7)-x(8)-x(9)))+...
    (1/b2)*x(8)*(a2+r2*log(C2*x(11)+D2)-log(x(8))+log(1-x(7)-x(8)-x(9)))+...
    (1/b3)*x(9)*(a3+r3*log(C3*x(12)+D3)-log(x(9))+log(1-x(7)-x(8)-x(9))))+...
    theta^3*((1/b1)*x(10)*(a1+r1*log(C1*x(13)+D1)-log(x(10))+log(1-x(10)-x(11)-x(12)))+...
    (1/b2)*x(11)*(a2+r2*log(C2*x(14)+D2)-log(x(11))+log(1-x(10)-x(11)-x(12)))+...
    (1/b3)*x(12)*(a3+r3*log(C3*x(15)+D3)-log(x(12))+log(1-x(10)-x(11)-x(12))))+...
    theta^4*((1/b1)*x(13)*(a1+r1*log(C1*x(16)+D1)-log(x(13))+log(1-x(13)-x(14)-x(15)))+...
    (1/b2)*x(14)*(a2+r2*log(C2*x(17)+D2)-log(x(14))+log(1-x(13)-x(14)-x(15)))+...
    (1/b3)*x(15)*(a3+r3*log(C3*x(18)+D3)-log(x(15))+log(1-x(13)-x(14)-x(15))))+...
    theta^5*((1/b1)*x(16)*(a1+r1*log(C1*x(19)+D1)-log(x(16))+log(1-x(16)-x(17)-x(18)))+...
    (1/b2)*x(17)*(a2+r2*log(C2*x(20)+D2)-log(x(17))+log(1-x(16)-x(17)-x(18)))+...
    (1/b3)*x(18)*(a3+r3*log(C3*x(21)+D3)-log(x(18))+log(1-x(16)-x(17)-x(18))))+...
    theta^6*((1/b1)*x(19)*(a1+r1*log(C1*x(22)+D1)-log(x(19))+log(1-x(19)-x(20)-x(21)))+...
    (1/b2)*x(20)*(a2+r2*log(C2*x(23)+D2)-log(x(20))+log(1-x(19)-x(20)-x(21)))+...
    (1/b3)*x(21)*(a3+r3*log(C3*x(24)+D3)-log(x(21))+log(1-x(19)-x(20)-x(21))))+...
    theta^7*((1/b1)*x(22)*(a1+r1*log(C1*x(25)+D1)-log(x(22))+log(1-x(22)-x(23)-x(24)))+...
    (1/b2)*x(23)*(a2+r2*log(C2*x(26)+D2)-log(x(23))+log(1-x(22)-x(23)-x(24)))+...
    (1/b3)*x(24)*(a3+r3*log(C3*x(27)+D3)-log(x(24))+log(1-x(22)-x(23)-x(24))))+...
    theta^8*((1/b1)*x(25)*(a1+r1*log(C1*x(28)+D1)-log(x(25))+log(1-x(25)-x(26)-x(27)))+...
    (1/b2)*x(26)*(a2+r2*log(C2*x(29)+D2)-log(x(26))+log(1-x(25)-x(26)-x(27)))+...
    (1/b3)*x(27)*(a3+r3*log(C3*x(30)+D3)-log(x(27))+log(1-x(25)-x(26)-x(27))))+...
    theta^9*((1/b1)*x(28)*(a1+r1*log(C1*x(31)+D1)-log(x(28))+log(1-x(28)-x(29)-x(30)))+...
    (1/b2)*x(29)*(a2+r2*log(C2*x(32)+D2)-log(x(29))+log(1-x(28)-x(29)-x(30)))+...
    (1/b3)*x(30)*(a3+r3*log(C3*x(33)+D3)-log(x(30))+log(1-x(28)-x(29)-x(30))))+...
    theta^10*((1/b1)*x(31)*(a1+r1*log(C1*x(34)+D1)-log(x(31))+log(1-x(31)-x(32)-x(33)))+...
    (1/b2)*x(32)*(a2+r2*log(C2*x(35)+D2)-log(x(32))+log(1-x(31)-x(32)-x(33)))+...
    (1/b3)*x(33)*(a3+r3*log(C3*x(36)+D3)-log(x(33))+log(1-x(31)-x(32)-x(33))))+...
    theta^11*((1/b1)*x(34)*(a1+r1*log(C1*x1+D1)-log(x(34))+log(1-x(34)-x(35)-x(36)))+...
    (1/b2)*x(35)*(a2+r2*log(C2*x2+D2)-log(x(35))+log(1-x(34)-x(35)-x(36)))+...
    (1/b3)*x(36)*(a3+r3*log(C3*x3+D3)-log(x(36))+log(1-x(34)-x(35)-x(36))))));
    
x0=[0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;...
    0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;...
    0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;...
    0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;];
lb=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;...
    0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;];
ub=[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;...
    1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;];
    
[xx1,fval1] = fmincon(f,x0,[],[],[],[],lb,ub);
```
After getting the market share, we bring back the expression of price and market share to get the price and calculate the final profit. The code is as follows:
```
p121=(1/b1)*(a1+r1*log(C1*xx1(4)+D1)-log(xx1(1))+log(1-xx1(1)-xx1(2)-xx1(3)))%price of the 12th month
p122=(1/b2)*(a2+r2*log(C2*xx1(5)+D2)-log(xx1(2))+log(1-xx1(1)-xx1(2)-xx1(3)))
p123=(1/b3)*(a3+r3*log(C3*xx1(6)+D3)-log(xx1(3))+log(1-xx1(1)-xx1(2)-xx1(3)))

p111=(1/b1)*(a1+r1*log(C1*xx1(7)+D1)-log(xx1(4))+log(1-xx1(4)-xx1(5)-xx1(6)))%price of the 11th month
p112=(1/b2)*(a2+r2*log(C2*xx1(8)+D2)-log(xx1(5))+log(1-xx1(4)-xx1(5)-xx1(6)))
p113=(1/b3)*(a3+r3*log(C3*xx1(9)+D3)-log(xx1(6))+log(1-xx1(4)-xx1(5)-xx1(6)))

p101=(1/b1)*(a1+r1*log(C1*xx1(10)+D1)-log(xx1(7))+log(1-xx1(7)-xx1(8)-xx1(9)))%price of the 10th month
p102=(1/b2)*(a2+r2*log(C2*xx1(11)+D2)-log(xx1(8))+log(1-xx1(7)-xx1(8)-xx1(9)))
p103=(1/b3)*(a3+r3*log(C3*xx1(12)+D3)-log(xx1(9))+log(1-xx1(7)-xx1(8)-xx1(9)))

p91=(1/b1)*(a1+r1*log(C1*xx1(13)+D1)-log(xx1(10))+log(1-xx1(10)-xx1(11)-xx1(12)))%price of the 9th month
p92=(1/b2)*(a2+r2*log(C2*xx1(14)+D2)-log(xx1(11))+log(1-xx1(10)-xx1(11)-xx1(12)))
p93=(1/b3)*(a3+r3*log(C3*xx1(15)+D3)-log(xx1(12))+log(1-xx1(10)-xx1(11)-xx1(12)))

p81=(1/b1)*(a1+r1*log(C1*xx1(16)+D1)-log(xx1(13))+log(1-xx1(13)-xx1(14)-xx1(15)))%price of the 8th month
p82=(1/b2)*(a2+r2*log(C2*xx1(17)+D2)-log(xx1(14))+log(1-xx1(13)-xx1(14)-xx1(15)))
p83=(1/b3)*(a3+r3*log(C3*xx1(18)+D3)-log(xx1(15))+log(1-xx1(13)-xx1(14)-xx1(15)))

p71=(1/b1)*(a1+r1*log(C1*xx1(19)+D1)-log(xx1(16))+log(1-xx1(16)-xx1(17)-xx1(18)))%price of the 7th month
p72=(1/b2)*(a2+r2*log(C2*xx1(20)+D2)-log(xx1(17))+log(1-xx1(16)-xx1(17)-xx1(18)))
p73=(1/b3)*(a3+r3*log(C3*xx1(21)+D3)-log(xx1(18))+log(1-xx1(16)-xx1(17)-xx1(18)))

p61=(1/b1)*(a1+r1*log(C1*xx1(22)+D1)-log(xx1(19))+log(1-xx1(19)-xx1(20)-xx1(21)))%price of the 6th month
p62=(1/b2)*(a2+r2*log(C2*xx1(23)+D2)-log(xx1(20))+log(1-xx1(19)-xx1(20)-xx1(21)))
p63=(1/b3)*(a3+r3*log(C3*xx1(24)+D3)-log(xx1(21))+log(1-xx1(19)-xx1(20)-xx1(21)))

p51=(1/b1)*(a1+r1*log(C1*xx1(25)+D1)-log(xx1(22))+log(1-xx1(22)-xx1(23)-xx1(24)))%price of the 5th month
p52=(1/b2)*(a2+r2*log(C2*xx1(26)+D2)-log(xx1(23))+log(1-xx1(22)-xx1(23)-xx1(24)))
p53=(1/b3)*(a3+r3*log(C3*xx1(27)+D3)-log(xx1(24))+log(1-xx1(22)-xx1(23)-xx1(24)))

p41=(1/b1)*(a1+r1*log(C1*xx1(28)+D1)-log(xx1(25))+log(1-xx1(25)-xx1(26)-xx1(27)))%price of the 4th month
p42=(1/b2)*(a2+r2*log(C2*xx1(29)+D2)-log(xx1(26))+log(1-xx1(25)-xx1(26)-xx1(27)))
p43=(1/b3)*(a3+r3*log(C3*xx1(30)+D3)-log(xx1(27))+log(1-xx1(25)-xx1(26)-xx1(27)))

p31=(1/b1)*(a1+r1*log(C1*xx1(31)+D1)-log(xx1(28))+log(1-xx1(28)-xx1(30)-xx1(29)))%price of the 3rd month
p32=(1/b2)*(a2+r2*log(C2*xx1(32)+D2)-log(xx1(29))+log(1-xx1(29)-xx1(28)-xx1(30)))
p33=(1/b3)*(a3+r3*log(C3*xx1(33)+D3)-log(xx1(30))+log(1-xx1(30)-xx1(29)-xx1(28)))

p21=(1/b1)*(a1+r1*log(C1*xx1(34)+D1)-log(xx1(31))+log(1-xx1(31)-xx1(32)-xx1(33)))%price of the 2nd month
p22=(1/b2)*(a2+r2*log(C2*xx1(35)+D2)-log(xx1(32))+log(1-xx1(32)-xx1(33)-xx1(31)))
p23=(1/b3)*(a3+r3*log(C3*xx1(36)+D3)-log(xx1(33))+log(1-xx1(33)-xx1(32)-xx1(31)))

p11=(1/b1)*(a1+r1*log(C1*x1+D1)-log(xx1(34))+log(1-xx1(35)-xx1(34)-xx1(36)))%price of the 1st month
p12=(1/b2)*(a2+r2*log(C2*x2+D2)-log(xx1(35))+log(1-xx1(34)-xx1(35)-xx1(36)))
p13=(1/b3)*(a3+r3*log(C3*x3+D3)-log(xx1(36))+log(1-xx1(34)-xx1(36)-xx1(35)))

x121 = xx1(1) %market share of last month
x122 = xx1(2) 
x123 = xx1(3)
x111=xx1(4)
x112=xx1(5)
x113=xx1(6)
x101=xx1(7)
x102=xx1(8)
x103=xx1(9)
x91=xx1(10)
x92=xx1(11)
x93=xx1(12)
x81=xx1(13)
x82=xx1(14)
x83=xx1(15)
x71=xx1(16)
x72=xx1(17)
x73=xx1(18)
x61=xx1(19)
x62=xx1(20)
x63=xx1(21)
x51=xx1(22)
x52=xx1(23)
x53=xx1(24)
x41=xx1(25)
x42=xx1(26)
x43=xx1(27)
x31=xx1(28)
x32=xx1(29)
x33=xx1(30)
x21=xx1(31)
x22=xx1(32)
x23=xx1(33)
x11=xx1(34)
x12=xx1(35)
x13=xx1(36)

pi12 = p121*xx1(1)+p122*xx1(2)+p123*xx1(3) 
pi11 = p111*xx1(4)+p112*xx1(5)+p113*xx1(6)
pi10 = p101*xx1(7)+p102*xx1(8)+p103*xx1(9)
pi9 = p91*xx1(10)+p92*xx1(11)+p93*xx1(12)
pi8 = p81*xx1(13)+p82*xx1(14)+p83*xx1(15)
pi7 = p71*xx1(16)+p72*xx1(17)+p73*xx1(18)
pi6 = p61*xx1(19)+p62*xx1(20)+p63*xx1(21)
pi5 = p51*xx1(22)+p52*xx1(23)+p53*xx1(24)
pi4 = p41*xx1(25)+p42*xx1(26)+p43*xx1(27)
pi3 = p31*xx1(28)+p32*xx1(29)+p33*xx1(30)
pi2 = p21*xx1(31)+p22*xx1(32)+p23*xx1(33)
pi1 = p11*xx1(34)+p12*xx1(35)+p13*xx1(36)

pi=[pi1 pi2 pi3 pi4 pi5 pi6 pi7 pi8 pi9 pi10 pi11 pi12] 
q1=[xx1(34) xx1(31) xx1(28) xx1(25) xx1(22) xx1(19) xx1(16) xx1(13) xx1(10) xx1(7) xx1(4) xx1(1)]
q2=[xx1(35) xx1(32) xx1(29) xx1(26) xx1(23) xx1(20) xx1(17) xx1(14) xx1(11) xx1(8) xx1(5) xx1(2)]
q3=[xx1(36) xx1(33) xx1(30) xx1(27) xx1(24) xx1(21) xx1(18) xx1(15) xx1(12) xx1(9) xx1(6) xx1(3)]
p1=[p11 p21 p31 p41 p51 p61 p71 p81 p91 p101 p111 p121]
p2=[p12 p22 p32 p42 p52 p62 p72 p82 p92 p102 p112 p122]
p3=[p13 p23 p33 p43 p53 p63 p73 p83 p93 p103 p113 p123]
pipi=pi12+pi11+pi10+pi9+pi8+pi7+pi6+pi5+pi4+pi3+pi2+pi1 %total revenue
```
<!-- Myopic File -->
#### Myopic File
In the myopic file, we divide the products according to the product category. Taking the code file "pi110.m" as an example, we first input the correlation coefficient required by the model.
```
a1=1.15;a2=1.16;a3=1.12;b1=0.16;b2=0.25;b3=0.29;D1=2.06;D2=2.03;D3=2.03;r1=0.67;r2=0.78;r3=0.69;C1=9.99;C2=10.01;C3=10.00;
x1=0;x2=0;x3=0;t=1;
```
After that, the market share is established as the decision variable and the single period profit maximization is taken as the goal. The code is as follows:
```
syms q1 q2 q3
eq1=a1+r1*log(C1*x1+D1)-log(q1)-1+log(1-q1-q2-q3)-(b1/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
eq2=a2+r2*log(C2*x2+D2)-log(q2)-1+log(1-q1-q2-q3)-(b2/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
eq3=a3+r3*log(C3*x3+D3)-log(q3)-1+log(1-q1-q2-q3)-(b3/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
[q1,q2,q3]=solve(eq1,eq2,eq3,q1,q2,q3)
```
Finally, price and total profit are solved according to the one-to-one correspondence between market share and price:
```
p1=(1/b1)*(a1-log(q1)+log(1-q1-q2-q3))
p2=(1/b2)*(a2-log(q2)+log(1-q1-q2-q3))
p3=(1/b3)*(a3-log(q3)+log(1-q1-q2-q3))
pi=(1/b1)*q1*(a1+r1*log(C1*x1+D1)-log(q1)+log(1-q1-q2-q3))+(1/b2)*q2*(a2+r2*log(C2*x2+D2)-log(q2)+log(1-q1-q2-q3))+(1/b3)*q3*(a3+r3*log(C3*x3+D3)-log(q3)+log(1-q1-q2-q3))
```
<!-- Onestep File -->
#### Onestep File
In the onestep file, we divided the products according to product categories. Taking the code file "onestep110.m" as an example, we first input the correlation coefficient required by the model.
```
a1=1.15;a2=1.16;a3=1.12;b1=0.16;b2=0.25;b3=0.29;D1=2.06;D2=2.03;D3=2.03;r1=0.67;r2=0.78;r3=0.69;C1=9.99;C2=10.01;C3=10.00;
x1=0;x2=0;x3=0;theta=0.99;t=1;
```
Then, the profit function is established with the goal of two-stage profit maximization, and the upper and lower bounds of the initial value and decision variables are set up to solve the problem. The code looks like this:
```
f=@(x)(-((1/b1)*x(1)*(a1+r1*log(C1*x(4)+D1)-log(x(1))+log(1-x(1)-x(2)-x(3)))+(1/b2)*x(2)*(a2+r2*log(C2*x(5)+D2)-log(x(2))+log(1-x(1)-x(2)-x(3)))+(1/b3)*x(3)*(a3+r3*log(C3*x(6)+D3)-log(x(3))+log(1-x(1)-x(2)-x(3)))+theta*((1/b1)*x(4)*(a1+r1*log(C1*x1+D1)-log(x(4))+log(1-x(4)-x(5)-x(6)))+(1/b2)*x(5)*(a2+r2*log(C2*x2+D2)-log(x(5))+log(1-x(4)-x(5)-x(6)))+(1/b3)*x(6)*(a3+r3*log(C3*x3+D3)-log(x(6))+log(1-x(4)-x(5)-x(6))))));
x0=[0.01;0.01;0.01;0.01;0.01;0.01];
lb=[0;0;0;0;0;0];
ub=[1;1;1;1;1;1];
[xx1,fval1] = fmincon(f,x0,[],[],[],[],lb,ub);
```
Finally, the one-to-one correspondence between price and market share is used to solve the price and total profit:
```
p11=(1/b1)*(a1+r1*log(C1*x1+D1)-log(xx1(4))+log(1-xx1(4)-xx1(5)-xx1(6)))
p12=(1/b2)*(a2+r2*log(C2*x2+D2)-log(xx1(5))+log(1-xx1(4)-xx1(5)-xx1(6)))
p13=(1/b3)*(a3+r3*log(C3*x3+D3)-log(xx1(6))+log(1-xx1(4)-xx1(5)-xx1(6)))
p21=(1/b1)*(a1+r1*log(C1*xx1(4)+D1)-log(xx1(1))+log(1-xx1(1)-xx1(2)-xx1(3)))
p22=(1/b2)*(a2+r2*log(C2*xx1(5)+D2)-log(xx1(2))+log(1-xx1(1)-xx1(2)-xx1(3)))
p23=(1/b3)*(a3+r3*log(C3*xx1(6)+D3)-log(xx1(3))+log(1-xx1(1)-xx1(2)-xx1(3)))
x1 = xx1(1); 
x2 = xx1(2);
x3 = xx1(3);
pi1 = p11*xx1(4)+p12*xx1(5)+p13*xx1(6);
pi2 = p21*xx1(1)+p22*xx1(2)+p23*xx1(3);
p1=[p1 p11 p21]
p2=[p2 p12 p22]
p3=[p3 p13 p23]
q1=[q1 xx1(4) xx1(1)]
q2=[q2 xx1(5) xx1(2)]
q3=[q3 xx1(6) xx1(3)]
pi=[pi pi1 pi2]
sum(pi)
```
<!-- Nop File -->
#### Nop File
In the nop file, we divided the products according to product categories. Taking the code file "pinop110.m" as an example, we first input the correlation coefficient required by the model.
```
a1=1.29;a2=1.20;a3=1.23;b1=0.13;b2=0.27;b3=0.34;
x1=0;x2=0;x3=0;t=1;
```
After that, the market share is established as the decision variable and the single-period profit maximization is taken as the goal. The code is as follows:
```
syms q1 q2 q3
eq1=a1-log(q1)-1+log(1-q1-q2-q3)-(b1/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
eq2=a2-log(q2)-1+log(1-q1-q2-q3)-(b2/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
eq3=a3-log(q3)-1+log(1-q1-q2-q3)-(b3/(1-q1-q2-q3))*(q1/b1+q2/b2+q3/b3);
[q1,q2,q3]=solve(eq1,eq2,eq3,q1,q2,q3)
```
Finally, price and total profit are solved according to the one-to-one correspondence between market share and price:
```
p1=(1/b1)*(a1-log(q1)+log(1-q1-q2-q3))
p2=(1/b2)*(a2-log(q2)+log(1-q1-q2-q3))
p3=(1/b3)*(a3-log(q3)+log(1-q1-q2-q3))
pi=(1/b1)*q1*(a1-log(q1)+log(1-q1-q2-q3))+(1/b2)*q2*(a2-log(q2)+log(1-q1-q2-q3))+(1/b3)*q3*(a3-log(q3)+log(1-q1-q2-q3))
```

<!-- CONTACT -->
## Contact

Email - luy1021@mail.ustc.edu.cn

Project Link: [https://github.com/luy1021/Myopic](https://github.com/luy1021/Myopic)



