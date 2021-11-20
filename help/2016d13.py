def solve(start, target = None, fill = None):
    '''
    Solve the given puzzle.

    If target is a point, return the steps needed to get to that point
    If fill is a number, return all points that can be reached in that many steps
    '''

    q = queue.Queue()
    visited = set()

    q.put((start, []))

    while not q.empty():
        (x, y), steps = q.get()

        # If we're in target mode and found the target, return how we got there
        if target and x == target[0] and y == target[1]:
            return steps

        # If we're in fill mode and have gone too far, bail out
        if fill and len(steps) > fill:
            continue

        visited.add((x, y))

        # Add any neighbors we haven't seen yet (don't run into walls)
        for xd, yd in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
            if (x + xd, y + yd) in visited:
                continue

            if wall(x + xd, y + yd):
                continue

            q.put(((x + xd, y + yd), steps + [(x, y)]))

    if fill:
        return visited

    raise Exception('Cannot reach target')
