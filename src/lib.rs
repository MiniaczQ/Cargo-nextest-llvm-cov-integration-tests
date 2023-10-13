fn foobar(foo: bool, bar: bool) {
    if foo {
        println!("foo");
    } else {
        println!("no foo");
    }
    if bar {
        println!("bar");
    } else {
        println!("no bar");
    }
}

#[cfg(test)]
mod tests {
    use crate::foobar;

    #[test]
    fn print_foo() {
        foobar(true, false);
    }
}
