close all
clear all
clc

data_test = importdata("TwoLeadECG_TEST.txt");
data_test = sortrows(data_test);

labels_test = data_test(:,1);
data_test(:,1)=[];

corr_matrix_test = corr(data_test');
dup = corr_matrix_test;

threshold = 1;
dup = dup > threshold;
G = graph(dup,'omitselfloops');
[bin,binsize] = conncomp(G);

 vidObj = VideoWriter('network_test.avi');
 open(vidObj);


while length(binsize) > 20
        dup = corr_matrix_test;
        dup = dup > threshold;
        G = graph(dup,'omitselfloops');
        
        plot(G,'-w','NodeCData',labels_test,'Layout','force')
        colorbar
        set(gca,'Color','k')
        title(sprintf('Threshold =  %d ' ,threshold))
        
        F = getframe(gcf);
        writeVideo(vidObj,F);
        [bin,binsize] = conncomp(G);
        threshold = threshold - 0.0001;
end

close(vidObj);