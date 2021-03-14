function [X_matrix] = X_mat(series)
%creates a matrix of daily, weekly and monthly RV from a daily RV series

% weekly RV
bw = (1/5)*ones(1,5);
RV_w = filter(bw,1,series);

for i=1:5-1
    RV_w(i)=RV_w(i)*5/i;
end

% monthly RV
bm = (1/22)*ones(1,22);
RV_m = filter(bm,1,series);

for i=1:22-1
    RV_m(i)=RV_m(i)*22/i;
end

X_matrix = [series RV_w RV_m];

end

