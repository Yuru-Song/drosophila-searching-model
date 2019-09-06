% clear all;
sample_num = 40;
trial_num = 20;
Xm = 0; 
Ym = 0; 
Xf = rand(sample_num, 1) * 2 * 2 - 2; 
Yf = rand(sample_num, 1) * 2 * 2 - 2; 
Rf = .8; 
delta = .05; 
theta = 2 * pi;
T = 36000;
thrshld = 3;%%
alpha = 1 - linspace(0, 0.4, T);
for i = 1: sample_num
    for j = 1: trial_num
    [x, y, isfound_2(i, j), time_found_2(i, j)] = random_walk_searching_2d_finite_space(alpha, Xm, Ym, Xf(i), Yf(i), Rf, delta, theta, T, thrshld);
    end
end