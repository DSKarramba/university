% Модель атома Томаса-Ферми
%Ландау "Квантовая механика" стр. 291- 295
dat = [
0.00 1.00
0.02 0.972
0.04 0.947
0.06 0.924
0.08 0.902
0.10 0.882
0.2 0.793
0.3 0.721
0.4 0.660
0.5 0.607
0.6 0.561
0.7 0.521
0.8 0.485
0.9 0.453
1.0 0.424
1.2 0.374
1.4 0.333
1.6 0.298
1.8 0.268
2.0 0.243
2.2 0.221
2.4 0.202
2.6 0.185
2.8 0.170
3.0 0.157
3.2 0.145
3.4 0.134
3.6 0.125
3.8 0.116
4.0 0.108
4.5 0.0919
5.0 0.0788
6 0.0594
7 0.0461
8 0.0366
9 0.0296
10 0.0243
11 0.0202
12 0.0171
13 0.0145
14 0.0125
15 0.0108
20 0.0058
25 0.0035
30 0.0023
40 0.0011
50 0.00063
60 0.00039];
x0 = 1.e-10;
khi0 = interp1(dat(:,1),dat(:,2),x0);
a1 = 1-khi0;
dat(1,1) = 1.e-10;;
dat(1,2) = khi0;;
x_L = dat(:,1);;
khi = dat(:,2);;
b = 0.885;;
Z = [6 13 29 47 79];;
N_L = length(x_L);;
Z1 = 6;;
rZ1 = x_L*b*Z1^(-1/3);;
fiCZ1 = Z1./rZ1;;
fiZ1 = fiCZ1.*khi;;
Z2 = 79;;
rZ2 = x_L*b*Z2^(-1/3);;
fiCZ2 = Z2./rZ2;;
fiZ2 = fiCZ2.*khi;;
% Пределы применимости;
figure(1);
set("current_figure",1);
pZ1 = (2*fiZ1).^0.5;;
lambdaZ1 = 2*pi./pZ1;;
rminZ1 = 1/Z1;;
pmaxZ1 = interp1(rZ1,pZ1,rminZ1);;
pZ2 = (2*fiZ2).^0.5;;
lambdaZ2 = 2*pi./pZ2;;
rminZ2 = 1/Z2;;
pmaxZ2 = interp1(rZ2,pZ2,rminZ2);;
plot(rZ1,[pZ1,lambdaZ1], rZ2,[pZ2,lambdaZ2],rminZ1,pmaxZ1,rminZ2,pmaxZ2);
%xtitle(['Limits evaluation'],'r, a.u.','p, lambda, a.u.');
function ydot = screening(x,y);
ydot =[y(2) y(1)^1.5/sqrt(x)];;
endfunction;
%-1.588128995];
y0 = [khi0 -1.58805155];;
clear Y;
N_x = 10;
x = x0:0.1:60;;
Y = ode("stiff",y0,x0,x,screening);;
N = length(Y);
sol = Y(1:2:N);;
N_x =length(x);;
clear x1;
x1 = x(100:1:N_x-100);;
inf_sol = 144*x1.^(-3);;
clear Y;
%figure(2);
%set("current_figure",2);
%plot(x,sol, x_L,khi,'+', x1,inf_sol),
%xlabel('x, a.u.'), ylabel('Screening koefficient'),
%legend('numerical integration','Landau', 'analitical solution');
%sol_x_L = interp1(x,sol,x_L);;
%abs_error = (sol_x_L - khi);;
%rel_error = abs_error./khi;;
%figure(3);
%set("current_figure",3);
%plot2d(x_L,[rel_error abs_error]),
%xtitle('Error evalution','x_L','Error'),
%legend('rel. error','abs. error');
%figure(4);
%set("current_figure",4);
%plot2d(rZ1,[fiZ1, fiCZ1],style=[1,2],logflag="ll");
%plot2d(rZ2,[fiZ2, fiCZ2],style=[3,4],logflag="ll");
%xtitle(['Atom potential and Coulmb potential for C and Au'],'r, a.u.','V, a.u.');
%legend('Thomas-Fermi','Coulomb');
%figure(5);
%set("current_figure",5);
%nZ1 = Z1^2*32/(9*pi^3)*((khi./x_L).^(3/2));;
%nZ2 = Z2^2*32/(9*pi^3)*((khi./x_L).^(3/2));;
%plot2d(rZ1,nZ1,style = 2, logflag="nl"),
%plot2d(rZ2,nZ2,style=3,logflag="nl");
%xtitle(['Electron density for C and Au'],'r, a.u.','n, a.u.');
%figure(6);
%set("current_figure",6);
%n_rZ1 = nZ1.*(4*pi*rZ1.^2);;
%n_rZ2 = nZ2.*(4*pi*rZ2.^2);;
%plot2d(rZ1,n_rZ1,style = 2, logflag="nl"),
%plot2d(rZ2,n_rZ2,style=3, logflag="nl");
%xtitle(['Radial electron density for C and Au'],'r, a.u.','n, a.u.');
%% Число электронов в сфере радиусом r;
%NZ1(1) = 0; NZ2(1) = 0;;
%UZ1(1) = 0; UZ2(1) = 0;;
%for j = 1:N_L-1;
%NZ1(j+1) = NZ1(j) + 0.5*(rZ1(j+1)-rZ1(j))*(n_rZ1(j+1)+n_rZ1(j));;
%UZ1(j+1) = UZ1(j) + 0.5*(rZ1(j+1) - rZ1(j))*(n_rZ1(j+1)^(5/3)*rZ1(j+1) + n_rZ1(j)^(5/3)*rZ1(j));;
%NZ2(j+1) = NZ2(j) + 0.5*(rZ2(j+1)-rZ2(j))*(n_rZ2(j+1)+n_rZ2(j));;
%UZ2(j+1) = UZ2(j) + 0.5*(rZ2(j+1) - rZ2(j))*(n_rZ2(j+1)^(5/3)*rZ2(j+1) + n_rZ2(j)^(5/3)*rZ2(j));;
%end;
%UZ1 =-(3*pi)^(2/3)*pi*UZ1;;
%UZ2 =-(3*pi)^(2/3)*pi*UZ2;;
%TZ1 = -UZ1/2;;
%TZ2 = -UZ2/2;;
%EZ1 = UZ1/2;;
%EZ2 = UZ2/2;;
%EZ1_a = -20.8*Z1^(7/3);;
%EZ2_a = -20.8*Z2^(7/3);;
%figure(7);
%set("current_figure",7);
%plot(rZ1, NZ1, rZ2, NZ2),
%xtitle(['Number of electrons inside sphere r'],'r, a.u.','N(r)');;
%r_05_C = 1.33*Z1^(-1/3);;
%r_05_Au = 1.33*Z2^(-1/3);;
%%Potential, kinetic and total energy;
%figure(8);
%set("current_figure",8);
%plot(rZ1,UZ1*27.2/2, rZ1,TZ1*27.2/2, rZ1,EZ1*27.2/2,
%rZ2,UZ2*27.2/2, rZ2,TZ2*27.2/2, rZ2,EZ2*27.2/2,
%rZ1(N_L),EZ1_a,'o',rZ2(N_L),EZ2_a,'o'),
%xlabel('r, a.u.'), ylabel('U(r), T(r), E(r), eV');
%title(['Potential, kinetic and total energy of electrons inside sphere r'],'r,
%a.u.','U(r), eV');
%% Average velocity of electrons;
%vZ1=sqrt(2*TZ1);;
%vZ2=sqrt(2*TZ2);;
%vZ1_a = Z1^(2/3);;
%vZ2_a = Z2^(2/3);;
%figure(9);
%set("current_figure",9);
%plot(rZ1,vZ1, rZ2,vZ2, rZ1(N_L),vZ1_a,'bo', rZ2(N_L),vZ2_a,'gd' ),
%xlabel('r, a.u.'), ylabel('v, a.u.'),
%title('Average velocity of electrons inside sphere r');;
%% Ions;
%y0 = [khi0 -1.58];;
%x1 = [x0:0.1:4.3];;
%Y = ode("stiff",y0,x0,x1,screening);;
%N = length(Y);
%sol_1 = Y(1:2:N);;
%clear Y;
%y0 = [khi0 -1.57];;
%x2 = [x0:0.1:3.45];;
%Y = ode("stiff",y0,x0,x2,screening);;
%N = length(Y);
%sol_2 = Y(1:2:N);;
%clear Y;
%y0 = [khi0 -1.6];;
%x3 = [x0:0.1:3.4];;
%Y = ode("stiff",y0,x0,x3,screening);;
%N = length(Y);
%sol_3 = Y(1:2:N);;
%figure(10);
%set("current_figure",10);
%plot(x(1:50),sol(1:50),'+', x1,sol_1, x2,sol_2, x3,sol_3),
%
