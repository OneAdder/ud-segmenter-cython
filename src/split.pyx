#cython: language_level=3
from random import randint

def get_init_split(unicode s):
    return [0, len(s)]

def divide(list split):
    assert(len(split) > 1)
    cdef int r = randint(1, len(split) - 1)
    cdef int rr
    if split[r-1] < split[r] - 1:
        # Copy because insert modifies object.
        split = split.copy()
        rr = randint(split[r-1] + 1, split[r] - 1)
        split.insert(r, rr)
    return split

def join(list split):
    assert(len(split) > 2)
    cdef int r = randint(1, len(split) - 2)
    # Copy because pop modifies object.
    cdef list new_split = split.copy()
    new_split.pop(r)
    return new_split

def move(list split):
    assert(len(split) > 2)
    cdef int r = randint(1, len(split)-2)
    cdef int d = randint(0, 1)
    if d:
        if split[r-1] < split[r] - 1:
            # Copy because we modify object.
            split = split.copy()            
            split[r] -= 1
    else:
        if split[r] < split[r+1] - 1:
            # Copy because we modify object.
            split = split.copy()            
            split[r] += 1
    return split

def sample_next(list split, int max_splits):
    cdef int r = randint(0, 2)
    
    if r == 0 and len(split)-1 < max_splits:
        split = divide(split)
    elif r == 1:
        if (len(split) > 2):
            split = join(split)
    else:
        if (len(split) > 2):
            split = move(split)
    return split

def sample_nth(int n, list split, int max_splits):
    for i in range(n):
        split = sample_next(split, max_splits)
    return split

def get_str(int i, list split, unicode wf):
#    assert(i < len(split) - 1)
    if i >= len(split) - 1:
        return ""
    return wf[split[i]: split[i+1]]
