use <parallel_tube.scad>;

shift = 50;
height = 100;
start = height;
P = [[0, -start],
     [0, 0],
     [shift, height],
     [shift, height + start]
    ];
n = 10;
tube_diameter = 100;
tube_thickness = 2;

difference() {
    parallel_tube(P, n, tube_diameter);
    parallel_tube(P, n, tube_diameter - tube_thickness);
}