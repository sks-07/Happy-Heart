close all
clear all
clc

data_train = importdata("TwoLeadECG_TEST.txt");
data_train = sortrows(data_train);

labels_train = data_train(:,1);
data_train(:,1)=[];

corr_matrix_train = corr(data_train');
dup = corr_matrix_train;

threshold = 1;
dup = dup > threshold;
G = graph(dup,'omitselfloops');
[bin,binsize] = conncomp(G);

 vidObj = VideoWriter('corr_test.avi');
 open(vidObj);


while length(binsize) > 2
        dup = corr_matrix_train;
        dup = dup > threshold;
        G = graph(dup,'omitselfloops');
        
%         plot(G,'NodeCData',labels_train,'Layout','force')
%         colorbar
%         set(gca,'Color','k')
        imagesc(dup)
        colorbar
        title(sprintf('Threshold =  %d ' ,threshold))
        
        F = getframe(gcf);
        writeVideo(vidObj,F);
        [bin,binsize] = conncomp(G);
        threshold = threshold - 0.0001;
end

close(vidObj);