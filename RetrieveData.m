%%%%% Retrieve ETF closing price (unadjusted) and dividend data for VTI and CBO.TO
VTI_Data = getYahooDailyData('VTI', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
CBO_Data = getGoogleDailyData('CBO.TO', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');

XIC_Data = getYahooDailyData('XIC.TO', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
IEFA_Data = getYahooDailyData('IEFA', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
IEMG_Data = getYahooDailyData('IEMG', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
XHY_Data = getYahooDailyData('XHY.TO', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');

% PFC401_Data = getYahooDailyData('PFC401', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
% PFC801_Data = getYahooDailyData('PFC801', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
% PFC382_Data = getYahooDailyData('PFC382', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
% PFC101_Data = getYahooDailyData('PFC101', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');

%%%%% Create financial time-series objects
VTI = fints(table2array(VTI_Data.VTI(:,1)),table2array(VTI_Data.VTI(:,5)),'VTI');
CBO = fints(table2array(CBO_Data.CBO0x2ETO(:,1)),table2array(CBO_Data.CBO0x2ETO(:,5)),'CBO');

XIC = fints(table2array(XIC_Data.XIC0x2ETO(:,1)),table2array(XIC_Data.XIC0x2ETO(:,5)),'XIC');
IEFA = fints(table2array(IEFA_Data.IEFA(:,1)),table2array(IEFA_Data.IEFA(:,5)),'IEFA');
IEMG = fints(table2array(IEMG_Data.IEMG(:,1)),table2array(IEMG_Data.IEMG(:,5)),'IEMG');
XHY = fints(table2array(XHY_Data.XHY0x2ETO(:,1)),table2array(XHY_Data.XHY0x2ETO(:,5)),'XHY');


clear VTI_Data CBO_Data XIC_Data IEFA_Data IEMG_Data PFC401_Data PFC801_Data...
      PFC382_Data XHY_Data PFC101_Data

%%%%% Make price adjustments for splits
%% For VTI, a 2:1 split occured on 06/18/2008, so adjust the close prices from this date
VTI('06/18/2008::10/31/2014') = VTI('06/18/2008::10/31/2014')*2;

%% For XIC, a 4:1 split occured on 08/06/2008, so adjust the close prices from this date
XIC('08/06/2008::10/31/2014') = XIC('08/06/2008::10/31/2014')*4;


%%%%% calcuulate daily log-returns of the closing prices
VTI_returns = log(VTI ./ lagts(VTI,1));
VTI_returns = VTI_returns(2:end);

CBO_returns = log(CBO ./ lagts(CBO,1));
CBO_returns = CBO_returns(2:end);

%%%%% Intersect the two log-returns series to estimate covariance matrix
VTI_CBO_returns = merge(VTI_returns, CBO_returns,'DateSetMethod','Intersection');
corr_est = corr(fts2mat(VTI_CBO_returns.CBO),fts2mat(VTI_CBO_returns.VTI));

%%%%% Estimate parameters
% VTI_estimates.mean = nanmean(VTI_returns);
% VTI_estimates.sd = sqrt(var(VTI_returns));
% VTI_estimates.N = length(VTI_returns);
% 
% CBO_estimates.mean = nanmean(CBO_returns);
% CBO_estimates.sd = sqrt(var(CBO_returns));
% CBO_estimates.N = length(CBO_returns);
% 
% return_est = [VTI_estimates.mean CBO_estimates.mean];
% cov_est = [VTI_estimates.sd^2 corr_est*VTI_estimates.sd*CBO_estimates.sd;
%            corr_est*VTI_estimates.sd*CBO_estimates.sd CBO_estimates.sd^2];
       




