set(groot,'defaultAxesTickLabelInterpreter', 'latex');
set(groot,'defaultAxesFontSize', 11);
set(groot,'defaultAxesGridAlpha', 0.3);
set(groot,'defaultAxesLineWidth', 0.75);
set(groot,'defaultAxesXMinorTick', 'on');
set(groot,'defaultAxesYMinorTick', 'on');
set(groot,'defaultLegendBox','off');
set(groot,'defaultFigureRenderer','painters');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultLegendLocation','best');
set(groot,'defaultLineLineWidth',1);
set(groot,'defaultLineMarkerSize',3);
set(groot,'defaultTextInterpreter','latex');
F     = 1.6*9.81;
Ld    = 0.025;
f     = linspace(0.11,0.5);
alpha = 38.512;
eta   = tand(alpha)./tand(alpha+atand(f));
flim  = tand(atand(tand(alpha)/0.5)-alpha);
Tb    = F*Ld*eta/2/pi;
%%
figure
plot(f,eta,'*')
xlabel('Friction coefficient f')
ylabel('Lead screw efficiency')
hold on
[a,b] = min(abs(f-flim));
plot(flim,eta(b),'r*','MarkerSize',5)
hold on
yline(eta(b));
xline(f(b));
hold off
legend('Curve','Limiting case')
figure
plot(f,Tb,'*')
xlabel('Friction coefficient f')
ylabel('Brake Torque $T_b$')