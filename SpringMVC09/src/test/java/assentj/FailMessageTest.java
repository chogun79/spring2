package assentj;

import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.*;

//7. description (에러 메세지)
//에러 메세지의 경우 as라는 메서드로 지정할 수 있다.
//단, as 메서드는 assertions이 수행되기전에 사용해야한다.
public class FailMessageTest {

    class Member {
        private String name;
        private int age;

        public Member(String name, int age) {
            this.name = name;
            this.age = age;
        }

        public String getName() {
            return name;
        }

        public int getAge() {
            return age;
        }

    }
    
    @Test
    @DisplayName("에러 메세지 출력")
    public void test() {
        Member frodo = new Member("Frodo", 100);
        frodo.getAge();
        // failing assertion, remember to call as() before the assertion, not after !
        assertThat(frodo.getAge())
                .as("check %s's age", frodo.getName())  // as를 assertion 이전에 넣는다.
                .isEqualTo(100); // 나이가 100과 같은지 비교
    }
    
    //8. filtering assertions - iterables or array에 적용
    @Test
    @DisplayName("람다식을 이용한 필터링")
    public void filterTest() {
        //given
        List<Member> list = new ArrayList<>();
        Member kim = new Member("Kim", 22);
        Member park = new Member("Park", 25);
        Member lee = new Member("Lee", 22);
        Member amy = new Member("Amy", 25);
        Member jack = new Member("Jack", 22);

        list.add(kim); list.add(park);
        list.add(lee); list.add(amy);
        list.add(jack);

        // when && then
        assertThat(list).filteredOn(human -> human.getName().contains("a"))
                .containsOnly(park, jack);
    }
    
    //9. extracting
    //리스트에서 특정 필드만 뽑아서 테스트 가능
    @Test
    @DisplayName("특정 속성 추출 테스트")
    public void extractTest() {
        //given
        List<Member> list = new ArrayList<>();
        Member kim = new Member("Kim", 22);
        Member park = new Member("Park", 25);
        Member lee = new Member("Lee", 22);
        Member amy = new Member("Amy", 25);
        Member jack = new Member("Jack", 22);

        list.add(kim);
        list.add(park);
        list.add(lee);
        list.add(amy);
        list.add(jack);

        // then
        assertThat(list).extracting("name")
                .contains("Kim", "Park", "Lee", "Amy", "Jack");
    }
    
    //여러 필드를 검사하고 싶을 경우 tuple 사용
    @Test
    @DisplayName("특정 속성 추출 테스트2")
    public void extractTest2() {
        //given
        List<Member> list = new ArrayList<>();
        Member kim = new Member("Kim", 22);
        Member park = new Member("Park", 25);
        Member lee = new Member("Lee", 22);
        Member amy = new Member("Amy", 25);
        Member jack = new Member("Jack", 22);

        list.add(kim);
        list.add(park);
        list.add(lee);
        list.add(amy);
        list.add(jack);

        // then
        assertThat(list).extracting("name", "age")
                .contains(tuple("Kim", 22),
                        tuple("Park", 25),
                        tuple("Lee", 22),
                        tuple("Amy", 25),
                        tuple("Jack",22));
    }
    
    //10. Soft assertions
    //Soft assertions를 사용하면 모든 assertions을 실행한 후 실패 내역만 확인 가능
    @Test
    @DisplayName("soft assertions로 한번에 검증")
    public void softAssertionsTest() {
        int num1 = 3;
        int num2 = 5;
        String str = "hello";

        SoftAssertions softly = new SoftAssertions();
        softly.assertThat(num1).as("num1 is %d", num1).isEqualTo(5);
        softly.assertThat(num2).as("num2 is %d", num2).isEqualTo(6);
        softly.assertThat(str).as("str is %s", str).isEqualTo("hi");
        softly.assertAll();
    }
    
    //11. Exception 처리 테스트
    //assertThatThrownBy() 메서드를 통해서 예외 처리를 할 수 있다.
    @Test
    public void exceptionAssertionTest1() {
        // WHEN
        Throwable thrown = catchThrowable(() -> { throw new Exception("boom!"); });

        // THEN
        assertThat(thrown).isInstanceOf(Exception.class)
                .hasMessageContaining("boom");
    }
    @Test
    public void exceptionAssertionTest2() {
        assertThatThrownBy(() -> { throw new Exception("boom!"); })
                .isInstanceOf(Exception.class)
                .hasMessageContaining("boom");
    }
    
    //12. 자주 쓰이는 예외 처리 systax   - 에러남(나중에 써먹을일있으면 확인)
    //assertThatNullPointerException
    //assertThatIllegalArgumentException
    //assertThatIllegalStateException
    //assertThatIOException
//	@Test
//	 public void exceptionAssertionTest3() {
//		assertThatIOException().isThrownBy(() -> { throw new IOException("boom!"); })
//			.withMessage("%s!", "boom")
//			.withMessageContaining("boom")
//			.withNoCause();
//    }​
}