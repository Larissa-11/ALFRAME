%用B样条拟合方法获得的实际齿面点做TCA分析
%在改程序中同时考虑齿廓误差+齿距误差
tic
clear
clc
clf
PNum=3000;                         %设置迭代步长
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
PE1=flipud(PE(1:88))*(50/100);                                           %第一组误差值
PE2=PE(89:end)*(90/100);                                                 %第二组误差值
stem(PE1)
hold on 
stem(PE2,'r')
hold off
% PE=load('PE2.txt');
ProfileError= PE1;       %flipud(PE*6);
% an = 0.0000000012193; 
% alfa0 = 0.056921539864634; 
an = 0.0000000012042; 
alfa0 = 0.05592;       %  0.056921539864634     0.0619    0.0519;  0.0728
model = 4;
b=-0.00001;
mc=[an,alfa0,model,b];                                          % b为等距修形系数
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
% %%% %%%%%%%%%%   摆线轮1主要设计参数    %%%
% zc=11;                          %摆线轮齿数%
% zp=12;                          %针轮齿数%
% rp=90;                      %针齿分布圆半径%
% a=4;                          %偏心距%
% rrp=7;                          %针齿半径
% d_rrp=0;                   %等距修形量(正+表示砂轮半径增加)
% d_rp=0;                      %移距修形量（+表示针齿分布半径减小）
% deta=0;                         %转角修形量   
% %%% %%%%%%%%%%   摆线轮1主要设计参数    %%%
% zc=41;                          %摆线轮齿数%
% zp=42;                          %针轮齿数%
% rp=70;                      %针齿分布圆半径%
% a=1;                          %偏心距%
% rrp=2.5;                          %针齿半径
% d_rrp=0;                   %等距修形量(正+表示砂轮半径增加)
% d_rp=0;                      %移距修形量（+表示针齿分布半径减小）
% deta=0;                         %转角修形量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% 解tca方程组
                                    
st=1/PNum;                                      %fai1的步长
uk_min=0;                                       % 摆线轮自身转角的最小值
uk_max=1;                                       % 摆线轮自身转角的最小值

%从参考点往齿顶计算
m1=0;
X1=zeros(2,4);
% fai1 =fai10;
% alfa_s1=alfa0;
uk=uk0;
X21=[fai10,fai20,beta10];
Cpoint1=zeros(2,5);

while uk >= uk_min
    [C,n_DC]=CurvePoint(uk,3,U,DPoint,U_d,Q1);
    xc =C(1);
    yc =C(2);
    nx_c=n_DC(1);
    ny_c=n_DC(2);
    
    [X2_1,fval]=fsolve('TCAequations',X21,optimset('fsolve'));
       if fval(1)>10^(-4)||fval(2)>10^(-4)||fval(3)>10^(-4)
            disp('已退出啮合');
            break;
       end
    m1=m1+1;
    Cpoint1(m1,:)=[C,n_DC];
    X1(m1,1:4)=[uk,X2_1];                       %从参考点往齿顶计算    
    uk=uk-st;
     X21=X2_1;
   fai1=X2_1(1);
    if fai1 < 0
        disp('已经计算到齿顶');
        break;
    end
end
%从参考点往齿根计算
m2=0;
X2=zeros(2,4);
uk=uk0;
X22=[fai10,fai20,beta10];
Cpoint2=zeros(2,5);
while uk <= uk_max                                     %从参考点往齿根计算
    [C,n_DC]=CurvePoint(uk,3,U,DPoint,U_d,Q1);
    xc =C(1);
    yc =C(2);
    nx_c=n_DC(1);
    ny_c=n_DC(2);  
    
    [X2_2,fval]=fsolve('TCAequations',X22,optimset('fsolve'));
        if fval(1)>10^(-4)||fval(2)>10^(-4)||fval(3)>10^(-4)       %判断方程的求解精度，精度太低，表明摆线轮已经不能正常的啮合了
            disp('已退出啮合');
            break;
        end
     m2=m2+1;
     Cpoint2(m2,:)=[C,n_DC];
     X2(m2,1:4)=[uk,X2_2];                                   %计算结果处理
     uk=uk+st;                                             %给phi1重新赋值
     X22=X2_2;
     fai1=X2_2(1);
     if fai1 > pi                                                %现在是等距修形取正值的时候，当取负值的时候需要再考虑
         disp('已退出啮合');                                  %对于移距修形，当phi1=0时，摆线轮需要转过一定的角度才能与针轮啮合
         break;                                              %若fai1<0，则已经失去意义 
     end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         对计算结果进行合并处理

% 先将计算结果整理
Xal_1=flipud(X1);
Xal_2=X2;
% Xall=[u,fai1,fai2,beta];
Xall=[Xal_1(2:end-1,1:4);Xal_2(1:end,1:4)];

% 再按照fai1从小到大的顺序排序,将排序结果赋给B_Xall
% B_index为排序结果
[B_Xall,B_index]=sortrows(Xall,2);

% 再讲排序的结果赋给Xall，仍然沿用以前的程序进行计算
Xall=B_Xall;
TE1=((Xall(:,3)-fai20)-(zp/zc)*(Xall(:,2)-fai10))*180*3600/pi;
%寻找传动误差的顶点
[TEmax,Index]=max(TE1);
% 第Index个数为所求的最大值。
TEmax;
Index;
TE1=TE1-TEmax;
% plot(Xall(:,2)*180/pi,TE1)
% 交点的求解范围
fai1_span1=(Xall(Index,2)-2*pi/zc)*180/pi;
fai1_span2=Xall(Index,2)*180/pi;

% 令A1/A2/A3分别代表三条传动误差曲线
x_A1=(Xall(:,2)-2*pi/zc)*180/pi;
x_A2=Xall(:,2)*180/pi;
x_A3=(Xall(:,2)+2*pi/zc)*180/pi;

A1_big=[x_A1,TE1];
A2_big=[x_A2,TE1];
A3_big=[x_A3,TE1];

% 在A1中确定搜索范围
N1_in_x_A1=FindSpan3(fai1_span1,x_A1);
N2_in_x_A1=FindSpan3(fai1_span2,x_A1);
% 在A2中确定搜索范围
N1_in_x_A2=FindSpan3(fai1_span1,x_A2);
N2_in_x_A2=FindSpan3(fai1_span2,x_A2);

A1_samll=A1_big(N2_in_x_A1:-1:N1_in_x_A1,:);
A2_samll=A2_big(N2_in_x_A2:-1:N1_in_x_A2,:);
% plot(A1_samll(:,1),A1_samll(:,2),'r')
figure(1)
clf
plot(A1_samll(:,1),A1_samll(:,2),'r*')
hold on 
plot(A2_samll(:,1),A2_samll(:,2),'g*')

grid on

Trans_err_max=sub_program0416(A2_samll,A1_samll);
% [X1,Trans_err_max]=Sub_search_intersection(A2_samll,A1_samll);



% clf
% plot(A1_big(:,1),A1_big(:,2),'r')
% hold on 
% plot(A2_big(:,1),A2_big(:,2),'g')
% plot(A3_big(:,1),A3_big(:,2),'b')
% hold off

% % 求解曲线交点
% [X1,f1]=Sub_search_intersection(A1,A2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%绘制传动误差图像
figure(2)
clf
plot(Xall(1:end-1,2)*180/pi,TE1(1:end-1),'r*','linewidth',1)
hold on
% for i=1:5
%     PDAngle=PitErAngle(i);
%     fai_next=Xall(1:end-1,2)+i*2*pi/zc;   
%     plot(fai_next*180/pi,TE1(1:end-1)-PDAngle,'g')  %正齿距误差，则滞后于理论值，若为负齿距误差，则超前进入啮合
% end
% hold off
fai1_L2=(Xall(:,2)-4*pi/zc)*180/pi;
fai1_L1=(Xall(:,2)-2*pi/zc)*180/pi;

fai1_R1=(Xall(:,2)+2*pi/zc)*180/pi;
fai1_R2=(Xall(:,2)+4*pi/zc)*180/pi;

plot(fai1_L2,TE1,'g','linewidth',1)
plot(fai1_L1,TE1,'b','linewidth',1)
plot(fai1_R1,TE1,'b','linewidth',1)
plot(fai1_R2,TE1,'g','linewidth',1)


hold off

grid on
xlabel('针轮转角/(°)','fontsize',16);
ylabel('传动误差/(″)','fontsize',16);
set(gca,'linewidth',1.5);    %设置坐标轴的线宽                                
set(gca,'FontName','Times New Roman','FontSize',16);    %获取当前坐标轴的柄，并设置字体大小

% axis([122 212 -1.5 1])
% axis([135 195 -20 0])
% 
% feval
% axis([86,136,-4,0])
axis([85,165,-10,0])


XX=['最大传动误差为:',num2str(Trans_err_max)];
disp(XX)


toc
