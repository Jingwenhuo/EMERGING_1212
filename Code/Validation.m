clear all;  %清变量
clc;    %清屏

GAP_data=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Code/Validation_result.xlsx','Fig VA'); %发展中国家_除中国印度
reulst_C(:,1)=(GAP_data(:,4)-GAP_data(:,3))./GAP_data(:,4).*100;
reulst_C(:,2)=(GAP_data(:,4)-GAP_data(:,5))./GAP_data(:,4).*100;
reulst_C(:,3)=(GAP_data(:,4)-GAP_data(:,6))./GAP_data(:,4).*100;
reulst_C(:,4)=(GAP_data(:,4)-GAP_data(:,7))./GAP_data(:,4).*100;
reulst_P(:,1)=(GAP_data(:,13)-GAP_data(:,12))./GAP_data(:,13).*100;
reulst_P(:,2)=(GAP_data(:,13)-GAP_data(:,14))./GAP_data(:,13).*100;
reulst_P(:,3)=(GAP_data(:,13)-GAP_data(:,15))./GAP_data(:,13).*100;
reulst_P(:,4)=(GAP_data(:,13)-GAP_data(:,16))./GAP_data(:,13).*100;


GAP_data2=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Code/Validation_result.xlsx','Fig VA2');
GAP_data2(isnan(GAP_data2))=0;
reulst_C2(:,1)=(GAP_data2(:,4)-GAP_data2(:,3))./GAP_data2(:,4).*100;
reulst_C2(:,2)=(GAP_data2(:,4)-GAP_data2(:,5))./GAP_data2(:,4).*100;
reulst_C2(:,3)=(GAP_data2(:,4)-GAP_data2(:,6))./GAP_data2(:,4).*100;
reulst_P2(:,1)=(GAP_data2(:,12)-GAP_data2(:,11))./GAP_data2(:,12).*100;
reulst_P2(:,2)=(GAP_data2(:,12)-GAP_data2(:,13))./GAP_data2(:,12).*100;
reulst_P2(:,3)=(GAP_data2(:,12)-GAP_data2(:,14))./GAP_data2(:,12).*100;

X1=GAP_data(:,8)./1000;
X2=GAP_data(:,17)./1000;
X3=GAP_data2(:,7)./1000;
X4=GAP_data2(:,15)./1000;

figure(1)
for i=1:63
    A=min(abs(reulst_C(i,:)));
    if abs(reulst_C(i,1))==A
        plot(X1(i,1),reulst_C(i,1),'o','MarkerSize',6,'MarkerFaceColor','r','MarkerEdgeColor','r');
     %text(X1(i,1),reulst_C(i,1),num2str(i))
     %   ylim([-40 40])
        hold on;
    elseif abs(reulst_C(i,2))==A
        plot(X1(i,1),reulst_C(i,2),'o','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','k');
     %text(X1(i,1),reulst_C(i,2),num2str(i))
      %  ylim([-40 40])
        hold on;
    elseif abs(reulst_C(i,3))==A
        plot(X1(i,1),reulst_C(i,3),'o','MarkerSize',6,'MarkerFaceColor','m','MarkerEdgeColor','m');
      %text(X1(i,1),reulst_C(i,3),num2str(i))
      %  ylim([-40 40])
    else
        plot(X1(i,1),reulst_C(i,4),'o','MarkerSize',6,'MarkerFaceColor','c','MarkerEdgeColor','c');
     %text(X1(i,1),reulst_C(i,4),num2str(i))
      % ylim([-40 40])
        hold on;
    end
    ylim([-100 100])
end

figure(2)
for i=1:63
    A=min(abs(reulst_P(i,:)));
    if abs(reulst_P(i,1))==A
        plot(X2(i,1),reulst_P(i,1),'o','MarkerSize',6,'MarkerFaceColor','r','MarkerEdgeColor','r');
      %text(X2(i,1),reulst_P(i,1),num2str(i))
     %  xlim([0 250])
        hold on;
    elseif abs(reulst_P(i,2))==A
        plot(X2(i,1),reulst_P(i,2),'o','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','k');
    %text(X2(i,1),reulst_P(i,2),num2str(i))
     % xlim([0 250])
        hold on;
    elseif abs(reulst_P(i,3))==A
        plot(X2(i,1),reulst_C(i,3),'o','MarkerSize',6,'MarkerFaceColor','m','MarkerEdgeColor','m');
    %text(X2(i,1),reulst_P(i,3),num2str(i))
      %  ylim([-40 40])
    else
        plot(X2(i,1),reulst_P(i,4),'o','MarkerSize',6,'MarkerFaceColor','c','MarkerEdgeColor','c');
     %text(X2(i,1),reulst_P(i,4),num2str(i))
     % xlim([0 250])
        hold on;
    end
    ylim([-100 100])
end

figure(3)
for i=1:181
    A=min(abs(reulst_C2(i,:)));
    if abs(reulst_C2(i,1))==A & A ~=100
        plot(X3(i,1),reulst_C2(i,1),'o','MarkerSize',6,'MarkerFaceColor','r','MarkerEdgeColor','r');
     %text(X3(i,1),reulst_C2(i,1),num2str(i))
     %   ylim([-40 40])
        hold on;
    elseif abs(reulst_C2(i,2))==A & A ~=100
        plot(X3(i,1),reulst_C2(i,2),'o','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','k');
     %text(X3(i,1),reulst_C2(i,2),num2str(i))
      %  ylim([-40 40])
        hold on;
    elseif abs(reulst_C2(i,3))==A & A ~=100
        plot(X3(i,1),reulst_C2(i,3),'o','MarkerSize',6,'MarkerFaceColor','c','MarkerEdgeColor','c');
     %text(X3(i,1),reulst_C2(i,3),num2str(i))
      %  ylim([-40 40])
    else
        plot(X3(i,1),0,'o','MarkerSize',6,'MarkerFaceColor','y','MarkerEdgeColor','y');
   % %text(X3(i,1),reulst_C2(i,4),num2str(i))
        hold on;
    end
    ylim([-100 100])
    xlim([0 600])
end

figure(4)
for i=1:181
    A=min(abs(reulst_P2(i,:)));
    if abs(reulst_P2(i,1))==A & A ~=100
        plot(X4(i,1),reulst_P2(i,1),'o','MarkerSize',6,'MarkerFaceColor','r','MarkerEdgeColor','r');
     %text(X4(i,1),reulst_P2(i,1),num2str(i))
     %  xlim([0 250])
        hold on;
    elseif abs(reulst_P2(i,2))==A & A ~=100
        plot(X4(i,1),reulst_P2(i,2),'o','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','k');
    %text(X4(i,1),reulst_P2(i,2),num2str(i))
     % xlim([0 250])
        hold on;
    elseif abs(reulst_P2(i,3))==A & A ~=100
        plot(X4(i,1),reulst_P2(i,3),'o','MarkerSize',6,'MarkerFaceColor','c','MarkerEdgeColor','c');
    %text(X4(i,1),reulst_P2(i,2),num2str(i))
      %  ylim([-40 40])
    else
        plot(X4(i,1),0,'o','MarkerSize',6,'MarkerFaceColor','y','MarkerEdgeColor','y');
      %%text(X2(i,1),reulst_P(i,3),num2str(i))
     % xlim([0 250])
        hold on;
    end
    ylim([-100 100])
    xlim([0 600])
end
