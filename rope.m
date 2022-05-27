% rope simulation

rope_lenght = 5;
element_count = 50;

elements_pos = zeros(2, element_count);
elements_spd = zeros(2, element_count);
elements_pos(1, :) = linspace(0, rope_lenght, element_count);

m = 0.1; % element weight
g = 0.01; % gravity
k = 5; % spring factor (multiplicated by lenght)
a = 0.01; % friction

dt = 0.15;

for i = 1:10000
    elements_forces = zeros(2, element_count);
    for col = 2:(size(elements_pos,2) - 1)
        prev_elem = elements_pos(:, col - 1);
        elem = elements_pos(:, col);
        next_elem = elements_pos(:, col + 1);
    
        left_diff = prev_elem - elem;
        right_diff = next_elem - elem;
    
        left_len = left_diff(1, 1)^2 + left_diff(2, 1)^2;
        right_len = right_diff(1, 1)^2 + right_diff(2, 1)^2;
    
        force = left_diff * left_len * k + right_diff * right_len * k;
    
        elements_forces(:, col) = force + [ 0 ; -g * m ];
    end
    elements_forces(2, 15) = elements_forces(2, 15) - g * m * 20;
    elements_forces = elements_forces - elements_spd * a * dt;

    %plot(linspace(0, rope_lenght, element_count), movement(1, :), linspace(0, rope_lenght, element_count), movement(2, :))
    elements_spd = elements_spd + elements_forces / m * dt;
    elements_pos = elements_pos + elements_spd * dt;

    plot(elements_pos(1, :), elements_pos(2, :), '-o');
    xlim([0 rope_lenght]);
    ylim([-10, 1]);
    drawnow;
end



figure;
