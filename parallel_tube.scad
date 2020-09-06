/*
A tube with parallel openings following a spline
*/
use <catmullrom.scad>;

module parallel_tube_points(xz, d) {
    union() {
        for (i=[0:len(xz)-2]) {
            x0 = xz[i][0];
            z0 = xz[i][1];
            x1 = xz[i+1][0];
            z1 = xz[i+1][1];
            
            dz = z1 - z0;
            dx = x1 - x0;
            
            translate([x0, 0, z0])
                multmatrix(m=[
                    [1, 0, dx/dz, 0],
                    [0, 1, 0, 0],
                    [0, 0, 1, 0]
                ])
                    cylinder(d=d, h=dz);           
        }
    }
}

module parallel_tube(P, n, d) {
    xz = spline(P, n);
    parallel_tube_points(xz, d);
}