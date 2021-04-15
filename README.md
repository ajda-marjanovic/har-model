**MATLAB code for Heterogeneous Autoregressive (HAR) model forecasting**

The HAR model is a simple autoregressive model for realized variance (and all its transformations - log/root etc.), which has the following form:

![image](https://user-images.githubusercontent.com/78689069/114883716-76cb6b80-9e05-11eb-982f-3ec112bc370a.png)

where the d,w and m subscripts represent daily, weekly and monthly realized variance. The model can be estimated by OLS.

The input for this code is a (n x 1) vector of realized variance or its transformations.

**X_mat.m** generates HAR regressors (daily, weekly and monthly RV) from the input,
**har_forecasting.m** makes rolling forecasts (one or multi-day horizons) and returns the RMSE value.
