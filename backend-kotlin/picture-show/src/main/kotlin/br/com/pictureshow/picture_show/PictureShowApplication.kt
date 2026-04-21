package br.com.pictureshow.picture_show

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class PictureShowApplication

fun main(args: Array<String>) {
	runApplication<PictureShowApplication>(*args)
}
