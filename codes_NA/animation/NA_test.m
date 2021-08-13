data = importdata("TwoLeadECG_TRAIN.txt");
labels = data(:,1);
data(:,1)=[];
corr_matrix = corr(data);

threshold_range = 0:0.1:1
for index = 1:length(threshold_range)
        dup = corr_matrix;
        thresh = threshold_range(index)
        dup = dup > thresh;
        G = graph(dup);
        figure()
        plot(G)
        title(sprintf('Threshold =  %d ' ,thresh))
        saveas(gcf,'thresh_'+string(thresh)+'.png')
        close
end
