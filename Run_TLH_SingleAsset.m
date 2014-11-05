%%%%% Run TLH on portfolio is single ETFs

initialDeposit = 100000;
initialWeights = [1];
thresholds = 0.02:0.005:0.2;
taxRate = 0.5*(0.29 + 0.1316);
taxRateEnd = 0.1;

%% VTI
VTI_Data = getYahooDailyData('VTI', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
VTI = fints(table2array(VTI_Data.VTI(:,1)),table2array(VTI_Data.VTI(:,5)),'VTI');
VTI('06/18/2008::10/31/2014') = VTI('06/18/2008::10/31/2014')*2;
VTI_returns = log(VTI ./ lagts(VTI,1));
VTI_returns = VTI_returns(2:end);
VTI_cumReturns = exp(cumsum(VTI_returns));

AfterTaxGain = nan(length(thresholds),1);
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0];

for i = 1:length(thresholds)
         [AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue PortfolioEndValueNoTLH...
          EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]      = TLH(fts2mat(VTI_returns.VTI),initialDeposit,initialWeights,...
                                                     thresholds(i),taxRate,taxRateEnd);
                                                
        AfterTaxGain(i) = AfterTaxGrowth;
        
        if AfterTaxGain(i) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i);
            currOptimalThreshold(1) = thresholds(i);
        end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
 PortfolioEndValue PortfolioEndValueNoTLH...
 EndCapitalGainsTax...
 HarvestedDates HarvestedAmounts]      = TLH(fts2mat(VTI_returns.VTI),initialDeposit,initialWeights,...
                                            currOptimalThreshold,taxRate,taxRateEnd);

VTI_harvestDates = VTI_cumReturns;
VTI_harvestDates(1:end) = 0;
VTI_harvestDates(HarvestedDates{1}) = VTI_cumReturns(HarvestedDates{1});
VTI_harvestDates = VTI_harvestDates(HarvestedDates{1});

plot(VTI_harvestDates,'ro');
hold on;
plot(VTI_cumReturns,'k-');
title('Cumulative Growth');

plot(thresholds,AfterTaxGain);
title('VTI: After Tax Gain vs TLH Threshold')

%% CBO
CBO_Data = getGoogleDailyData('CBO.TO', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
CBO = fints(table2array(CBO_Data.CBO0x2ETO(:,1)),table2array(CBO_Data.CBO0x2ETO(:,5)),'CBO');
CBO_returns = log(CBO ./ lagts(CBO,1));
CBO_returns = CBO_returns(2:end);
CBO_cumReturns = exp(cumsum(CBO_returns));

AfterTaxGain = nan(length(thresholds),1);
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0];

for i = 1:length(thresholds)
         [AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue PortfolioEndValueNoTLH...
          EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]      = TLH(fts2mat(CBO_returns.CBO),initialDeposit,initialWeights,...
                                                     thresholds(i),taxRate,taxRateEnd);
                                                
        AfterTaxGain(i) = AfterTaxGrowth;
        
        if AfterTaxGain(i) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i);
            currOptimalThreshold(1) = thresholds(i);
        end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
 PortfolioEndValue PortfolioEndValueNoTLH...
 EndCapitalGainsTax...
 HarvestedDates HarvestedAmounts]      = TLH(fts2mat(CBO_returns.CBO),initialDeposit,initialWeights,...
                                            currOptimalThreshold,taxRate,taxRateEnd);

CBO_harvestDates = CBO_cumReturns;
CBO_harvestDates(1:end) = 0;
CBO_harvestDates(HarvestedDates{1}) = CBO_cumReturns(HarvestedDates{1});
CBO_harvestDates = CBO_harvestDates(HarvestedDates{1});

plot(CBO_harvestDates,'ro');
hold on;
plot(CBO_cumReturns,'k-');
title('Cumulative Growth');

plot(thresholds,AfterTaxGain);
title('CBO: After Tax Gain vs TLH Threshold')

%% XIC
XIC_Data = getYahooDailyData('XIC.TO', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
XIC = fints(table2array(XIC_Data.XIC0x2ETO(:,1)),table2array(XIC_Data.XIC0x2ETO(:,5)),'XIC');
XIC('08/06/2008::10/31/2014') = XIC('08/06/2008::10/31/2014')*4;
XIC_returns = log(XIC ./ lagts(XIC,1));
XIC_returns = XIC_returns(2:end);
XIC_cumReturns = exp(cumsum(XIC_returns));

AfterTaxGain = nan(length(thresholds),1);
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0];

for i = 1:length(thresholds)
         [AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue PortfolioEndValueNoTLH...
          EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]      = TLH(fts2mat(XIC_returns.XIC),initialDeposit,initialWeights,...
                                                     thresholds(i),taxRate,taxRateEnd);
                                                
        AfterTaxGain(i) = AfterTaxGrowth;
        
        if AfterTaxGain(i) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i);
            currOptimalThreshold(1) = thresholds(i);
        end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
 PortfolioEndValue PortfolioEndValueNoTLH...
 EndCapitalGainsTax...
 HarvestedDates HarvestedAmounts]      = TLH(fts2mat(XIC_returns.XIC),initialDeposit,initialWeights,...
                                            currOptimalThreshold,taxRate,taxRateEnd);

XIC_harvestDates = XIC_cumReturns;
XIC_harvestDates(1:end) = 0;
XIC_harvestDates(HarvestedDates{1}) = XIC_cumReturns(HarvestedDates{1});
XIC_harvestDates = XIC_harvestDates(HarvestedDates{1});

plot(XIC_harvestDates,'ro');
hold on;
plot(XIC_cumReturns,'k-');
title('Cumulative Growth');

plot(thresholds,AfterTaxGain);
title('XIC: After Tax Gain vs TLH Threshold')

%% IEFA
IEFA_Data = getYahooDailyData('IEFA', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
IEFA = fints(table2array(IEFA_Data.IEFA(:,1)),table2array(IEFA_Data.IEFA(:,5)),'IEFA');
IEFA_returns = log(IEFA ./ lagts(IEFA,1));
IEFA_returns = IEFA_returns(2:end);
IEFA_cumReturns = exp(cumsum(IEFA_returns));

AfterTaxGain = nan(length(thresholds),1);
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0];

for i = 1:length(thresholds)
         [AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue PortfolioEndValueNoTLH...
          EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]      = TLH(fts2mat(IEFA_returns.IEFA),initialDeposit,initialWeights,...
                                                     thresholds(i),taxRate,taxRateEnd);
                                                
        AfterTaxGain(i) = AfterTaxGrowth;
        
        if AfterTaxGain(i) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i);
            currOptimalThreshold(1) = thresholds(i);
        end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
 PortfolioEndValue PortfolioEndValueNoTLH...
 EndCapitalGainsTax...
 HarvestedDates HarvestedAmounts]      = TLH(fts2mat(IEFA_returns.IEFA),initialDeposit,initialWeights,...
                                            currOptimalThreshold,taxRate,taxRateEnd);

IEFA_harvestDates = IEFA_cumReturns;
IEFA_harvestDates(1:end) = 0;
IEFA_harvestDates(HarvestedDates{1}) = IEFA_cumReturns(HarvestedDates{1});
IEFA_harvestDates = IEFA_harvestDates(HarvestedDates{1});

plot(IEFA_harvestDates,'ro');
hold on;
plot(IEFA_cumReturns,'k-');
title('Cumulative Growth');

plot(thresholds,AfterTaxGain);
title('IEFA: After Tax Gain vs TLH Threshold')

%% IEMG
IEMG_Data = getYahooDailyData('IEMG', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
IEMG = fints(table2array(IEMG_Data.IEMG(:,1)),table2array(IEMG_Data.IEMG(:,5)),'IEMG');
IEMG_returns = log(IEMG ./ lagts(IEMG,1));
IEMG_returns = IEMG_returns(2:end);
IEMG_cumReturns = exp(cumsum(IEMG_returns));

AfterTaxGain = nan(length(thresholds),1);
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0];

for i = 1:length(thresholds)
         [AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue PortfolioEndValueNoTLH...
          EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]      = TLH(fts2mat(IEMG_returns.IEMG),initialDeposit,initialWeights,...
                                                     thresholds(i),taxRate,taxRateEnd);
                                                
        AfterTaxGain(i) = AfterTaxGrowth;
        
        if AfterTaxGain(i) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i);
            currOptimalThreshold(1) = thresholds(i);
        end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
 PortfolioEndValue PortfolioEndValueNoTLH...
 EndCapitalGainsTax...
 HarvestedDates HarvestedAmounts]      = TLH(fts2mat(IEMG_returns.IEMG),initialDeposit,initialWeights,...
                                            currOptimalThreshold,taxRate,taxRateEnd);

IEMG_harvestDates = IEMG_cumReturns;
IEMG_harvestDates(1:end) = 0;
IEMG_harvestDates(HarvestedDates{1}) = IEMG_cumReturns(HarvestedDates{1});
IEMG_harvestDates = IEMG_harvestDates(HarvestedDates{1});

plot(IEMG_harvestDates,'ro');
hold on;
plot(IEMG_cumReturns,'k-');
title('Cumulative Growth');

plot(thresholds,AfterTaxGain);
title('IEMG: After Tax Gain vs TLH Threshold');

%% XHY
XHY_Data = getYahooDailyData('XHY.TO', '1/1/2000', '10/31/2014', 'mm/dd/yyyy');
XHY = fints(table2array(XHY_Data.XHY0x2ETO(:,1)),table2array(XHY_Data.XHY0x2ETO(:,5)),'XHY');
XHY_returns = log(XHY ./ lagts(XHY,1));
XHY_returns = XHY_returns(2:end);
XHY_cumReturns = exp(cumsum(XHY_returns));

AfterTaxGain = nan(length(thresholds),1);
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0];

for i = 1:length(thresholds)
         [AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue PortfolioEndValueNoTLH...
          EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]      = TLH(fts2mat(XHY_returns.XHY),initialDeposit,initialWeights,...
                                                     thresholds(i),taxRate,taxRateEnd);
                                                
        AfterTaxGain(i) = AfterTaxGrowth;
        
        if AfterTaxGain(i) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i);
            currOptimalThreshold(1) = thresholds(i);
        end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
 PortfolioEndValue PortfolioEndValueNoTLH...
 EndCapitalGainsTax...
 HarvestedDates HarvestedAmounts]      = TLH(fts2mat(XHY_returns.XHY),initialDeposit,initialWeights,...
                                            currOptimalThreshold,taxRate,taxRateEnd);

XHY_harvestDates = XHY_cumReturns;
XHY_harvestDates(1:end) = 0;
XHY_harvestDates(HarvestedDates{1}) = XHY_cumReturns(HarvestedDates{1});
XHY_harvestDates = XHY_harvestDates(HarvestedDates{1});

plot(XHY_harvestDates,'ro');
hold on;
plot(XHY_cumReturns,'k-');
title('Cumulative Growth');

plot(thresholds,AfterTaxGain);
title('XHY: After Tax Gain vs TLH Threshold');














