function [max_values, max_coords] = Fun_find_max(matrix, range_start, range_end)
    % 获取坐标和值
    coords = matrix(:, 1);
    values = matrix(:, 2);

    % 寻找范围内的极大值
    in_range_idx = find(coords >= range_start & coords <= range_end);
    values_in_range = values(in_range_idx);
    [~, sorted_idx] = sort(values_in_range, 'descend');
    top_20_values = values_in_range(sorted_idx(1:min(20, length(sorted_idx))));
    top_20_coords = coords(in_range_idx(sorted_idx(1:min(20, length(sorted_idx)))));

    % 绘制图形
    figure;
    plot(coords, values);
    hold on;

    % 绘制红色虚线从极大值到图窗的顶部
    for i = 1:length(top_20_values)
        x = top_20_coords(i);
        y = top_20_values(i);
        line([x x], [y max(values)], 'Color', 'red', 'LineStyle', '--')
        text(x, y, num2str(x), 'Color', 'red', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center')
    end
    hold off

    xlabel('Coordinate');
    ylabel('Value');
    title('Max Values in Matrix');

    % 返回极大值及其坐标，按原始顺序保存
    original_idx = in_range_idx(sorted_idx(1:min(20, length(sorted_idx))));
    max_values = values(original_idx);
    max_coords = coords(original_idx);
end
