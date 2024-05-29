package kr.bit.mapper;

import org.junit.Test;
import org.junit.jupiter.api.DisplayName;

import static org.junit.Assert.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.assertj.core.api.Assertions.*;

import java.util.List;
import kr.bit.service.LottoNumberGenerator;
//JUnit을 활용한 Java 단위 테스트 코드
/** 로또 생성기 Java코드 : 1000원을 주면 1개의 로또를 생성해주는 클래스 */
//1. 로또 번호 갯수 테스트
//2. 로또 번호 범위 테스트
//3. 잘못된 로또 금액 테스트

//[ given/when/then 패턴 ]
//1. given(준비): 어떠한 데이터가 준비되었을 때
//2. when(실행): 어떠한 함수를 실행하면
//3. then(검증): 어떠한 결과가 나와야 한다

//4. 메소드의 호출 횟수가 중요한 테스트에서는 어떤 메소드가 몇번 호출되었는지를 검사하기 위한 verify 단계도 사용할 수있다.(선택적사용)

/** 

[ 테스트 코드 작성 공통 규칙 ]
@DisplayName("로또 번호 갯수 테스트")
@Test
void lottoNumberSizeTest() {
   // given

   // when

   // then
}

*/

/**  1. AssertJ 라이브러리
	- 에러 메시지와 테스트 코드의 가독성을 높임
	- 개발자가 테스트를 하면서 필요한 거의 모든 메소드를 제공
	- 메소드 체이닝 지원 : 간결하고 읽기 쉬운 테스트코드 작성
	- 테스트에 필요한 거의 모든 메소드를 제공

2. 의존성 추가
<dependency>
    <groupId>org.assertj</groupId>
    <artifactId>assertj-core</artifactId>
    <version>3.21.0</version>
    <scope>test</scope>
</dependency>

import static org.assertj.core.api.Assertions.*; //3. 메소드 임폴트

주요 메소드
assertEquals(expected, actual); 
assertThat(actual).isEqualTo(expected);

4. 테스트 대상 지정
assertThat(테스트 타켓).메소드1().메소드2().메소드3() */

//https://kgvovc.tistory.com/58   <-- 사이트 참고
//JUnit을 활용한 Java 단위 테스트 코드
public class LottoNumberGeneratorTest {
	//@BeforeEach 애너테이션은 @Test애너테이션(하나이상일경우 포함) 실행 전에 수행된다.
	//@AfterEach 애너테이션은 @Test애너테이션(하나이상일경우 포함) 실행 후에 수행된다.
	//@BeforeAll 모든 테스트 메서드가 실행되기 전에 특정 작업을 수행해야 한다면
	//@AfterAll 모든 테스트 메서드가 실행된 후에 특정 작업을 수행해야 한다면
	//@Disabled 특정 테스트를 실행하기 싫을 때 : 테스트 실행 대상에서 제외
	//@DisplayName 테스트 결과에 애너테이션에 지정한 값을 표시한다.
	
	@DisplayName("1.로또 번호 갯수 테스트")
	@Test
	public void lottoNumberSizeTest() {
		// given : 	//우선 로또를 생성받기 위해서는 로또 생성기 객체와 금액이 필요하다. 그렇기에 given 단계에서는 LottoNumberGenerator 객체와 금액을 적어주면 된다.
		final LottoNumberGenerator lottoNumberGenerator = new LottoNumberGenerator();
		final int price = 1000;
		
		// when : 준비가 끝났으면 주어진 금액을 지불하여 로또를 받아야 한다. 이에 대한 when 단계의 코드를 작성하면 다음과 같다
		final List<Integer> lottoNumber = lottoNumberGenerator.generate(price);
		
		// then : 이제 최종적으로 우리가 받은 로또가 6개의 숫자를 갖는지 검증해야 한다.
		assertThat(lottoNumber.size()).isEqualTo(6);
	}
	
	@DisplayName("2.로또 번호 범위 테스트")
	@Test
	public void lottoRangeTest() {

		final LottoNumberGenerator lottoNumberGenerator = new LottoNumberGenerator();
		final int price = 1000;
		
		// when : 준비가 끝났으면 주어진 금액을 지불하여 로또를 받아야 한다. 이에 대한 when 단계의 코드를 작성하면 다음과 같다
		final List<Integer> lottoNumber = lottoNumberGenerator.generate(price);
		
		// then : 		
		//이번에는 모든 로또 숫자가 1에서 45사이의 숫자인지를 boolean 값으로 검사하므로,
		//AssertJ의 isTrue() 문법이 사용되었다. 그 외에도 isFalse(), isNull(), isNotNull() 등의 메소드가 있다.
		assertThat(lottoNumber.stream().allMatch(v -> v >= 1 && v <= 45)).isTrue();

	}
	
	@DisplayName("잘못된 로또 금액 테스트")
	@Test
	public void lottoNumberInvalidMoneyTest() {

		final LottoNumberGenerator lottoNumberGenerator = new LottoNumberGenerator();
		final int price = 1000;
		
		// when : 준비가 끝났으면 주어진 금액을 지불하여 로또를 받아야 한다. 이에 대한 when 단계의 코드를 작성하면 다음과 같다
		final RuntimeException exception = assertThrows(RuntimeException.class, () -> lottoNumberGenerator.generate(price));
		
		// then : 		
		assertThat(exception.getMessage()).isEqualTo("올바른 금액이 아닙니다.");

/*
이전 코드들과 다르게 금액을 2000원으로 변경하였고, 실행하는 메소드를 assertThrows()로 감싸 주었다.
간단한 자바 애플리케이션이라서 어떤 메소드가 다른 객체와 메세지를 주고 받을 필요가 없는 경우라면 단위 테스트 작성이 간단하다. 
하지만 일반적인 애플리케이션은 상당히 복잡하고, 여러 객체들이 메세지를 주고 받는다.
그렇기에 Spring과 같은 웹 애플리케이션에서는 어떻게 단위 테스트를 작성하는지에 대해 알아볼 필요가 있다.
*/
	}
	
	
	
	
	
	
	
	
	
	
	
	//5.문자열 테스트 예시
	@Test
	@DisplayName("테스트 코드 작성")
	public void numTest() {
	    assertThat("Hello, world! Nice to meet you.") // 주어진 "Hello, world! Nice to meet you."라는 문자열은
	            .isNotEmpty() // 비어있지 않고
	            .contains("Nice") // "Nice"를 포함하고
	            .contains("world") // "world"도 포함하고
	            .doesNotContain("ZZZ") // "ZZZ"는 포함하지 않으며
	            .startsWith("Hell") // "Hell"로 시작하고
	            .endsWith("u.") // "u."로 끝나며
	            .isEqualTo("Hello, world! Nice to meet you."); // "Hello, world! Nice to meet you."과 일치합니다.
	}
	
	//6. 숫자 테스트 예시
	@Test
	@DisplayName("숫자 테스트")
	public void test() {
	    assertThat(3.14d) // 주어진 3.14라는 숫자는
	            .isPositive() // 양수이고
	            .isGreaterThan(3) // 3보다 크며
	            .isLessThan(4) // 4보다 작습니다
	            .isEqualTo(3, offset(1d)) // 오프셋 1 기준으로 3과 같고
	            .isEqualTo(3.1, offset(0.1d)) // 오프셋 0.1 기준으로 3.1과 같으며
	            .isEqualTo(3.14); // 오프셋 없이는 3.14와 같습니다
	}	
	//7. description(에러메시지)
	

}
