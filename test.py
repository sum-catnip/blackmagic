def makework(_):
    return lambda: print("aaaa")


@makework
def pups(a: int, b: str):
    print(a, b)


async def pupsasync():
    """
    pennies
    """
    await pupsasync()
