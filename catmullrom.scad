/*
Centripetal Catmull–Rom spline fashioned after
https://en.wikipedia.org/wiki/Centripetal_Catmull%E2%80%93Rom_spline#Code_example_in_Python
*/

function tj(ti, Pi, Pj, alpha) =
    pow(pow(Pj[0]-Pi[0], 2) + pow(Pj[1]-Pi[1], 2), alpha / 2) + ti;

function c(P0, P1, P2, P3, t0, t1, t2, t3, t) =
    let(
        a1=(t1-t)/(t1-t0)*P0 + (t-t0)/(t1-t0)*P1,
        a2=(t2-t)/(t2-t1)*P1 + (t-t1)/(t2-t1)*P2,
        a3=(t3-t)/(t3-t2)*P2 + (t-t2)/(t3-t2)*P3,
        b1=(t2-t)/(t2-t0)*a1 + (t-t0)/(t2-t0)*a2,
        b2=(t3-t)/(t3-t1)*a2 + (t-t1)/(t3-t1)*a3
    )
    (t2-t)/(t2-t1)*b1 + (t-t1)/(t2-t1)*b2;

function range(a, b, n) = [for (x=[0:n]) x / n * (b - a) + a];

function spline_segment(P0, P1, P2, P3, n, alpha) =
    let(
        t0=0,
        t1=tj(t0, P0, P1, alpha),
        t2=tj(t1, P1, P2, alpha),
        t3=tj(t2, P2, P3, alpha)
    )
    [for(t=range(t1, t2, n)) c(P0, P1, P2, P3, t0, t1 ,t2, t3, t)];

function spline(P, n, alpha=0.5) =
    [for (i=[0:len(P)-4]) for(s=spline_segment(P[i], P[i+1], P[i+2], P[i+3], n, alpha)) s];