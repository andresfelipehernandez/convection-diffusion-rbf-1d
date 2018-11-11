%euclidean distance function


function [r]=norma(q1, q2)

r=sqrt((q1(1,1)-q2(1,1))^2+(q1(1,2)-q2(1,2))^2);
