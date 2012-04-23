#include <stdio.h>
#include <stdint.h>

int integer = -1;

int8_t integer_8 = -1;

int16_t integer_16 = -1;

int32_t integer_32 = -1;

int64_t integer_64 = -1;

unsigned int unsigned_integer = 0xffffffff;

uint8_t unsigned_integer_8 = -1;

uint16_t unsigned_integer_16 = -1;

uint32_t unsigned_integer_32 = -1;

uint64_t unsigned_integer_64 = -1;

float decimal_single_precision = 0.1234;

double decimal_double_precision = 0.1234;

char string[] = {"1234"};

unsigned char bytes[] = {"\x01\x02\x03\x04"};

int integer_array[] = {1, 2, 3, 4};

int8_t integer_8_array[] = {1, 2, 3, 4};

int16_t  integer_16_array[] = {1, 2, 3, 4};

int32_t integer_32_array[] = {1, 2, 3, 4};

int64_t integer_64_array[] = {1, 2, 3, 4};

unsigned int unsigned_integer_array[] = {1, 2, 3, 4};

uint8_t unsigned_integer_8_array[] = {1, 2, 3, 4};

uint16_t unsigned_integer_16_array[] = {1, 2, 3, 4};

uint32_t unsigned_integer_32_array[] = {1, 2, 3, 4};

uint64_t unsigned_integer_64_array[] = {1, 2, 3, 4};

float decimal_single_precision_array[] = {0.1, 0.2, 0.3, 0.4};

double decimal_double_precision_array[] = {0.1, 0.2, 0.3, 0.4};

char buffer[1024];

struct variable {
	const char *name;
	const void *address;
};

const struct variable variables[] = {
	{"integer", &integer},
	{"integer_8", &integer_8},
	{"integer_16", &integer_16},
	{"integer_32", &integer_32},
	{"integer_64", &integer_64},
	{"unsigned_integer", &unsigned_integer},
	{"unsigned_integer_8", &unsigned_integer_8},
	{"unsigned_integer_16", &unsigned_integer_16},
	{"unsigned_integer_32", &unsigned_integer_32},
	{"unsigned_integer_64", &unsigned_integer_64},
	{"decimal_single_precision", &decimal_single_precision},
	{"decimal_double_precision", &decimal_double_precision},
	{"string", &string},
	{"bytes", &bytes},
	{"integer_array", &integer_array},
	{"integer_8_array", &integer_8_array},
	{"integer_16_array", &integer_16_array},
	{"integer_32_array", &integer_32_array},
	{"integer_64_array", &integer_64_array},
	{"integer_64_array", &integer_64_array},
	{"unsigned_integer_array", &unsigned_integer_array},
	{"unsigned_integer_8_array", &unsigned_integer_8_array},
	{"unsigned_integer_16_array", &unsigned_integer_16_array},
	{"unsigned_integer_32_array", &unsigned_integer_32_array},
	{"unsigned_integer_64_array", &unsigned_integer_64_array},
	{"unsigned_integer_64_array", &unsigned_integer_64_array},
	{"decimal_single_precision_array", &decimal_single_precision_array},
	{"decimal_double_precision_array", &decimal_double_precision_array},
	{NULL, NULL}
};

void say()
{
	puts(string);
}

int main(int argc,const char *argv[])
{
	if (strcmp(argv[1],"--inspect") == 0)
	{
		const struct variable *var = variables;

		puts("---");

		while (var->name)
		{
			printf("%s: 0x%p\n", var->name, var->address);
			var++;
		}
		return 0;
	}

	while (1)
	{
  		say();
		sleep(2);
	}
	return 0;
}
