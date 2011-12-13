figure(1);
subplot(3,1,1);
hold on;
plot(features_ica(2,:)/max(features_ica(2,:)),'b');
plot(features(2,:)/max(features(2,:)),'r');

subplot(3,1,2);
hold on;
plot(features_ica(10,:)/max(features_ica(10,:)),'b');
plot(features(10,:)/max(features(10,:)),'r');

subplot(3,1,3);
hold on;
plot(features_ica(20,:)/max(features_ica(20,:)),'b');
plot(features(20,:)/max(features(20,:)),'r');