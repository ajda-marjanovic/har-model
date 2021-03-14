function [RMSE, errors] = har_forecasting(Z, s, R);

%inputs:
    %Z: RV series
    %s: forecast horizon
    %R: rolling window length
    
%outputs:
    %RMSE: root mean square error
    %errors: an array of forecast errors
    
r = length(Z) - R;

if s == 1

    for i=1:r-1
    
        series = Z(i:R+i-1);
        
        matrix = X_mat(series);
        
        X = [ones(length(matrix),1) matrix];
        Y = series(2:end);
        
        beta_hat(1,1:4) = X(1:end-1,:)\ Y;
        yhat (i,1) = X(end,:)*beta_hat(1,:)'
        observed(i,1) = Z(R+i);
        errors(i,1) = observed(i,1)-yhat(i,1);
    end
        
elseif s > 1
    
      for i=1:r-s
    
        series = Z(i:R+i-1);
        
        matrix = X_mat(series);
        
        X = [ones(length(matrix),1) matrix];
        Y = series(2:end);
        
        beta_hat(1,1:4) = X(1:end-1,:)\ Y;
        prediction (1,i) = X(end,:)*beta_hat(1,:)';
        observed(1,i) = Z(R+i);
        err(1,i) = observed(1,i)-prediction(1,i);
        
        for h = 1:s
        
            series2 = [Z(h+i:R+i-1); prediction(1:h,i)];
            
            matrix2 = X_mat(series2);
            
            X2 = [ones(length(matrix2),1) matrix2];
            Y2 = series2(2:end);
            
            beta_hat(h+1,1:4) = X2(1:end-1,:)\ Y2;
            prediction (h+1,i) = X2(end,:)*beta_hat(h+1,:)';
            observed(h+1,i) = Z(R+i+h);
            err(h+1,i) = observed(h+1,i)-prediction(h+1,i);
        end 
        
        errors(i,1) = err(end-1, i);
        yhat(i,1) = prediction(end-1,i);
      end
end

RMSE = sqrt(mean(errors.^2));
end