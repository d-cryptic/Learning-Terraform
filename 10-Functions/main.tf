output printfirst {
    #value = "first user is ${var.users[0]}"
    #value = "${join(",",var.users)}"
    value = "${join("-->", var.users)}"
}

output helloworldupper {
    value = "${upper(var.users[0])}"
}

output helloworldlower {
    value = "${lower(var.users[1])}"
}

output helloworldtitle {
    value = "${title(var.users[2])}"
}
