%Material Properties
%Sy = %linspace(350,284,7)' * 6.895;
Sall = 1440; %Sy/2;
e = 2.06E5;
raw = 7800; %(g/mm3)

%Initial Guess
Ho = 30;
Ledges = 25;
fs = 1.25;
%M1 = 400;

%Spring Dimensions
d = [1.5, 1.6, 1.8, 2];
Din = [8: 0.5 : 12]';

Dm = Din + d;
Do = Din + (2*d);

nexact = (Ho - d)./(d + 0.3);
n = round(nexact);
c = Dm ./ d;
k = (4*c - 1)./(4*c - 4);

%Spring Limits
Mmax = (22/7 *Sall.*(d.^3))./(32*k);
Phi_max = (360*Sall.*Dm.*n)./(e*(d.*k));

%Working Characteristics
G = Mmax ./ Phi_max;
Gd = (e*(d.^4))./(64.*(57.3).*Dm);
n_check = Gd./G;


M2 = Mmax ./ fs;
Phi2 = M2 ./ G;
Phi1 = Phi2 - 90;
M1 = Phi1 .* G;

%Phi1 = M1./G;
%Phi2 = Phi1 + 90;
%M2 = Phi2 .* G;

Smax = 32.* k .* Mmax * 7 /22 .* (d.^3);

%Changes due to loading
Dmd = (Dm)./(1 + (deg2rad(Phi2)./(2*(22/7)*n)));
Dind = Dmd - d;
Dod = Dmd + d;
delta = atan((d+0.3)./((22/7)*Dm));
dL = 0.5 * deg2rad(Phi2) .* Dm .* sin(delta);

%Physical Characterisitics
Laxial = 3.2 * Dm .* n;
m = (1E-6) * raw * 22 / 7 * (d.^2) / 4 .* (Laxial + (2*Ledges));