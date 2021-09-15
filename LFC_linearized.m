%% linearize model

model = 'LFC_model';

sys = linearize(model);

%% Plots
close all;
figure

subplot(2,3,1);
pzplot(sys);

subplot(2,3,2);
step(sys);

subplot(2,3,3);
impulse(sys);

subplot(2,3,4);
b=bodeplot(sys);
b.showCharacteristic('AllStabilityMargins');


subplot(2,3,5);
n=nicholsplot(sys);
n.showCharacteristic('AllStabilityMargins');

subplot(2,3,6);
y=nyquistplot(sys);
y.showCharacteristic('AllStabilityMargins');
