from math import inf


def floyd(dist):
    for k in range(len(dist)):
        for i in range(len(dist)):
            for j in range(len(dist)):
                dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
    return dist


if __name__ == '__main__':

    john_example = [
        [0, 20, inf, inf, 70],
        [-10, 0, 40, inf, inf],
        [inf, -30, 0, -10, inf],
        [inf, inf, 20, 0, 50],
        [-60, inf, inf, -40, 0]
    ]
    ddm = [
        [0, 120, 10, inf, 105, inf],
        [-60, 0, inf, 0, inf, 40],
        [0, inf, 0, 70, inf, inf],
        [inf, inf, -60, 0, inf, inf],
        [-30, inf, inf, inf, 0, 0],
        [inf, -30, inf, inf, 0, 0]
    ]

    ddm = floyd(ddm)
    for row in ddm:
        print(row)
