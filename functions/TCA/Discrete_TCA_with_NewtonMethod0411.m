%用B样条拟合方法获得的实际齿面点做TCA分析
%在改程序中同时考虑齿廓误差+齿距误差

clear
clc
clf
PNum=500;                         %设置迭代步长
% % %%% 摆线轮的主要设计参数 %%%
% zc=11;                            %摆线轮齿数%
% zp=12;                            %针轮齿数%
% rp=90;                            %针齿分布圆半径%
% a=4;                              %偏心距%
% rrp=7;                            %针齿半径
% d_rrp=0;                          %等距修形量
% d_rp=0;                           %移距修形量
% deta=0;       

zc=35;                            %摆线轮齿数%
zp=36;                            %针轮齿数%
rp=110;                            %针齿分布圆半径%
a=2.5;                              %偏心距%
rrp=6.5;                            %针齿半径
d_rrp=0;                    %等距修形量 ;00.2823
d_rp=0;                       %移距修形量;  0.12-0.1623
deta=0; 
% % % 输入齿面基本参数
% zc=41;                          %摆线轮齿数%
% zp=42;                          %针轮齿数%
% rp=70;                          %针齿分布圆半径%
% a=1;                            %偏心距%
% rrp=2.5;                        %针齿半径
% d_rrp=0.15;                        %等距修形量(正+表示砂轮半径增加)
% d_rp=0;                         %移距修形量（+表示针齿分布半径减小）
% deta=0;                         %转角修形量
% % % 输入齿面基本参数
% zc=39;                            %摆线轮齿数%
% zp=40;                            %针轮齿数%
% rp=114.5;                         %针齿分布圆半径%
% a=2.2;                            %偏心距%
% rrp=5;                            %针齿半径
% d_rrp=0.015;                          %等距修形量
% d_rp=0.015;                           %移距修形量
% deta=0;  

% BasicParameter=[39,40,114.5,2.2,5,0,0,0];

% zc=41;                          %摆线轮齿数%
% zp=42;                          %针轮齿数%
% rp=70;                          %针齿分布圆半径%
% a=1;                            %偏心距%
% rrp=2.5;                        %针齿半径
% d_rrp=0;                        %等距修形量(正+表示砂轮半径增加)
% d_rp=0;                         %移距修形量（+表示针齿分布半径减小）
% deta=0;                         %转角修形量
BasicParameter=[zc,zp,rp,a,rrp,d_rrp,d_rp,deta];    %摆线轮基本参数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_h=zp/zc;
k10=a*zp/rp;                        %理论短幅系数
k1=a*zp/(rp-d_rp);                  %修形之后短幅系数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k1_2=a*zp/(rp-d_rp)
K=[0,0,1];          %z轴方向单位向量
R_ca=(rp-d_rp)+a-(rrp+d_rrp);       %摆线轮的齿顶圆半径
R_ia=(rp-d_rp)-a-(rrp+d_rrp);       %摆线轮的齿根圆半径
R_half=R_ia+(R_ca-R_ia)*(7/10);


% R_ca=(rp-d_rp)+a-(rrp+d_rrp);       %摆线轮的齿顶圆半径
% R_ia=(rp-d_rp)-a-(rrp+d_rrp);       %摆线轮的齿根圆半径

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 读取齿距误差，并转化成角度偏差
PitEr=load('PitchError0.txt');             %不考虑齿距误差
% PitEr=load('PitchError0312_2.txt');             %摆线轮齿距误差
% PitEr=load('PitchError03_5_3600.txt');             %摆线轮齿距误差
Sum_PitEr=sum(PitEr);
stem(PitEr)                               % 绘制齿距误差的图像
PitErAngle=PitEr/R_half;          %将齿距误差转化成角度偏差，先将弧长单位化成m,再求解弧度制角度
PitErAngle=(PitErAngle*180/pi)*3600;      %将齿距误差的角度转化成秒
clf
stem(PitErAngle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf
% PE1=load('ProfileError1.txt');
% stem(PE1)
PE=load('profileErr04_5.txt');
PE1=flipud(PE(1:88))*(40/100);                                           %第一组误差值
PE2=PE(89:end);                                                 %第二组误差值
stem(PE1)
hold on 
stem(PE2,'r')
hold off
% PE=load('PE2.txt');
ProfileError= PE1;       %flipud(PE*6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 失配修形点
an = 0.0000000015242; 
alfa0 =0.056921539864634;        %      0.0619
model = 4;
mc=[an,alfa0,model];
RealTP=CalculateRealToothPoint(BasicParameter,ProfileError,mc);    %将误差加入，生成真实齿面点
plot(RealTP(:,1),RealTP(:,2),'*')
InPar=RealTP;
[ControlPoint,NodeVector]=BYT_Fitting(InPar,3);                 %计算得到拟合曲线的控制顶点和节点矢量
U=NodeVector;                                                   %将前面计算的节点矢量赋给U
DPoint=ControlPoint;                                            %将前面计算的控制顶点矢量赋给DPoint
U_d=U(2:end-1);                                                 %导函数的节点矢量
N_DPoint=length(DPoint(:,1));                                   %控制顶点个数
Q1=CurveDerivCpts(N_DPoint-1,3,U,DPoint);                       %导函数的控制顶点
% 至此曲线的拟合部分已全部计算完毕，得到了U、DPoint、U_d、Q1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义变量
global fai1 fai2 beta1 xc yc nx_c ny_c
syms fai1 fai2 alfa beta1 xc yc nx_c ny_c real
% fai1为转化轮系中针轮转角
% fai2为摆线轮1的转角，即输出角
% alfa为摆线轮c1的齿廓方程参数
% beta1为针轮的齿廓参数

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 摆线轮1到固定坐标系的坐标转换%
M_fc1=[cos(fai2),-sin(fai2),0,0;
    sin(fai2),cos(fai2),0,-a;
    0,0,1,0;
    0,0,0,1];
% 针轮到固定坐标系的坐标转换%
M_fp1=[cos(fai1),-sin(fai1),0,0;
       sin(fai1),cos(fai1),0,0;
       0,0,1,0;
       0,0,0,1];
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %摆线轮方程
CurvePoint0=[xc,yc,0,1]';
equa_c1=CurvePoint0;                              %摆线轮拟合齿面点
% % 齿顶在最上关于y轴对称
% equa_c1=[((rp-d_rp)-(rrp+d_rrp)/sqrt(1+k1^2-2*k1*cos(zc*(alfa+pi))))*sin((1-i_h)*zc*(alfa+pi)-deta)+a/(rp-d_rp)*(rp-d_rp-zp*(rrp+d_rrp)/sqrt(1+k1^2-2*k1*cos(zc*(alfa+pi))))*sin(i_h*zc*(alfa+pi)+deta);
%          -(((rp-d_rp)-(rrp+d_rrp)/sqrt(1+k1^2-2*k1*cos(zc*(alfa+pi))))*cos((1-i_h)*zc*(alfa+pi)-deta)-a/(rp-d_rp)*(rp-d_rp-zp*(rrp+d_rrp)/sqrt(1+k1^2-2*k1*cos(zc*(alfa+pi))))*cos(i_h*zc*(alfa+pi)+deta));
%           0;
%           1]; 

% 针齿方程
equa_r1=[-rrp*sin(beta1);rp-rrp*cos(beta1);0;1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 对于拟合出的曲线，此部分不需要，因为在b样条拟合已经求出了单位法矢
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %对摆线轮方程的单位法向量
n_DC0=[nx_c,ny_c,0];
n_c1=n_DC0;
%求针轮法线时，因为两个轮的法线方向相反，所以求法向量叉乘时，两个向量交换位置
%对针轮方程求法向量
d_equa_r1_beta1=diff(equa_r1,'beta1',1);                %针齿求切矢
d2=d_equa_r1_beta1(1:3)';
N_p1=cross(K,d2);                                       %N_p1的值为复数，可能有问题，后面可能需要调整
M1=sqrt(N_p1(1)^2+N_p1(2)^2+N_p1(3)^2);                 %法向量的模
n_p1=N_p1/M1;                                           %针轮上接触点处的单位法向量

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               将4个向量都表示在固定坐标系（机架坐标系）中
f_rc1=M_fc1*equa_c1;                                     %摆线轮方程转化到固定坐标系中
f_rp1=M_fp1*equa_r1;                                     %针轮方程在固定坐标戏中表示

f_nc1=M_fc1(1:3,1:3)*n_c1';                              %摆线轮上接触点处单位法向量在固定坐标系中表示
f_np1=M_fp1(1:3,1:3)*n_p1';                              %针轮上接触点处单位法向量在固定坐标系中表示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             列TCA方程（在固定坐标系中)，三个方程，三个未知量，
F1=f_rc1(1)-f_rp1(1);                                        % x_rc1=x_rp1，不能用f_rc1(1)=f_rp1(1)，因为这是赋值
F2=f_rc1(2)-f_rp1(2);                                        % y_rc1=y_rp1，同上
F3=f_nc1(2)-f_np1(2);                                        % x_nc1=x_np1,因为是单位向量，x与y之间存在关系，所以不用表示x_nc1=x_np1      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       建立TCA方程组
fid=fopen('TCAequations.m','wt+');
fprintf(fid,'%s\n','function p=TCAequations(q)');
fprintf(fid,'%s\n','global xc yc nx_c ny_c');
fprintf(fid,'%s\n','fai1=q(1);fai2=q(2);beta1=q(3);');     
fprintf(fid,'%s\n','p=zeros(3,1);');
fprintf(fid,'%s','p(1)=');
fprintf(fid,'%s\n',strcat(char(F1),';'));
fprintf(fid,'%s','p(2)=');
fprintf(fid,'%s\n',strcat(char(F2),';'));
fprintf(fid,'%s','p(3)=');
fprintf(fid,'%s\n',strcat(char(F3),';'));
fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                      计算啮合起点㈠
%指定啮合起点
U_First_No=find_u_firstSpan(R_half,U,DPoint,3);  %初始参考点的u值坐在区间的节点下标
[x_span,y_span]=equation_fit(U_First_No,3,U,DPoint);    %拟合曲线段函数
ff1=x_span^2+y_span^2-R_half^2;
%建立求解初始参考点的函数
fid=fopen('equation_of_Initial_point.m','wt+');
fprintf(fid,'%s\n','function f=equation_of_Initial_point(x)');
fprintf(fid,'%s\n','u=x');     
fprintf(fid,'%s','f=');
fprintf(fid,'%s\n',strcat(char(ff1),';'));
fclose(fid);

%求解初始参考点的函数
x0=(U(U_First_No+1)+U(U_First_No+2))/2;
[uk0,fval]=fsolve('equation_of_Initial_point',x0);

% uk0=0.4174;
% 求曲线上的点和该点对应的单位法向量
[C,n_DC]=CurvePoint(uk0,3,U,DPoint,U_d,Q1);
C;
n_DC;
C=[C,0,1]';
n_DC=n_DC';
f_rc0=M_fc1*C;
f_nc0=M_fc1(1:3,1:3)*n_DC;

F4=f_rc0(1)-f_rp1(1);                                        
F5=f_rc0(2)-f_rp1(2);                                        
F6=f_nc0(1)-f_np1(1); 

%先建立求解参考点方程
fid=fopen('CKDequation.m','wt+');
fprintf(fid,'%s\n','function f=CKDequation(q)');
fprintf(fid,'%s\n','fai1=q(1);fai2=q(2);beta1=q(3);');     
fprintf(fid,'%s\n','f=zeros(3,1);');
fprintf(fid,'%s','f(1)=');
fprintf(fid,'%s\n',strcat(char(F4),';'));
fprintf(fid,'%s','f(2)=');
fprintf(fid,'%s\n',strcat(char(F5),';'));
fprintf(fid,'%s','f(3)=');
fprintf(fid,'%s\n',strcat(char(F6),';'));
fclose(fid);
%求解参考点方程
[alfa00,fai100,fai200,beta00]=theoretical_mesh_point(R_half,BasicParameter);%给出理论参考点处的啮合转角
X00=[fai100,fai200,beta00];
[X,fval2]=fsolve('CKDequation',X00,optimset('fsolve')); 

fai10=X(1);
fai20=X(2);
beta10=X(3);
u0=uk0;

% u0=0.408841;
% beta10=0.9206275522;
% fai10=2.7333882;
% fai20=2.80932405;
% u0=0.500991;
% beta10=0.82281011292;
% fai10=2.85385228;
% fai20=2.93539092;

initial_point=[u0,beta10,fai10,fai20];

X1 = TCA_down_to_root( initial_point,DPoint,U,U_d,Q1,BasicParameter );
X2 = TCA_up_to_top( initial_point,DPoint,U,U_d,Q1,BasicParameter );

X2=flipud(X2);
Xall=[X2(:,1:4);X1(:,1:4)];
TE1=((Xall(:,4)-fai20)-(zp/zc)*(Xall(:,3)-fai10))*180*3600/pi;
[TEmax,Index]=max(TE1);
TE1=TE1-TEmax;


%绘制传动误差结果
clf
plot(Xall(1:end,3)*180/pi,TE1(1:end),'b','linewidth',1.5)
hold on 

fai1_L1=(Xall(:,3)-2*pi/zc)*180/pi;
fai1_L2=(Xall(:,3)-4*pi/zc)*180/pi;
fai1_R1=(Xall(:,3)+2*pi/zc)*180/pi;
fai1_R2=(Xall(:,3)+4*pi/zc)*180/pi;


plot(fai1_L1,TE1,'b','linewidth',1.5)
% plot(fai1_L2,TE1,'b','linewidth',1.5)

plot(fai1_R1,TE1,'b','linewidth',1.5)
% plot(fai1_R2,TE1,'b','linewidth',1.5)


grid on
xlabel('针轮转角/(°)','fontsize',16);
ylabel('传动误差/(″)','fontsize',16);
set(gca,'linewidth',1.5);    %设置坐标轴的线宽                                
set(gca,'FontName','Times New Roman','FontSize',16);    %获取当前坐标轴的柄，并设置字体大小

axis([80,150,-10,0])




